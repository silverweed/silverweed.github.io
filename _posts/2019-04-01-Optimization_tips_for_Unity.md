---
title: Optimization tips for Unity
author: silverweed
layout: single
tags:  
  - unity  
  - videogames  
  - programming  
  - optimization  
  - c#
---

I don't use Unity very much (especially since I mostly switched to [Godot Engine](https://godotengine.org) for hobby projects), but every now and then I come back to it for one reason or another.
I'm also following with interest the latest developments the engine is pursuing -- especially the new ECS ecosystem, which unfortunately I haven't tried yet (but I plan to do eventually).

That said, I thought I'd share a couple of small findings I've recently bumped into when optimizing some Unity gameplay code. Most, if not all, these tips are already written somewhere on the Internet, either in the Unity manual or in some other blog post out there; however, *repetita iuvant*, and these are all practical advices whose effectiveness I managed to verify through the (super helpful) Unity builtin profiler.

So, if you're looking for places in your code where fruits hang low optimization-wise, you may find this checklist helpful!

### Cache Enum values if you use them repeatedly!
A super-easy-to-fix potential issue: using `Enum.GetValues(typeof(EnumType))` in a tight loop, `Update()` method and so on. This method uses reflection to go through all the enumeration values and also allocates garbage memory, so it may steal precious milliseconds from your frame if you call it many times per frame.

A very easy solution is to compute it once and store it in a readonly variable inside some class. You can even put it in a static class for very convenient access throughout your whole program:

```
public static class MyEnumValues {
    public static readonly System.Array values = Enum.GetValues(typeof(MyEnum));
}
```

### Avoid Enum.HasFlag() on hot code!
This finding got me pretty surprised at first. 
As you may know, in C# you can flag an enum with the `[Flags]` attribute, which will, among other goodies, provide you with the `HasFlag()` method which you can use to test a bitmask value for a specific flag.
The problem is: calling `myEnum.HasFlag(flag)` allocates memory! This happens because of "boxing", which is, basically, C# needing an object to call the method on. Since the enum value is not an object, but rather a POD type, C# creates a new "boxing" object for it and calls the method on that object. This naturally causes a memory allocation, which is not that bad per-se, but can become quite taxing if the method is invoked numerous times during a frame.

The solution to this issue is to just check the flag the "good old way":
```
// This is equivalent to myEnum.HasFlag(flag)
bool hasFlag = (myEnum & flag) == flag;
```

### Clear() collections, don't reallocate them!
This is probably the most classic one, but it can be easy to overlook if you're not that experienced with Unity or are doing quick & dirty prototyping.
Long story short, allocating collections like `List` or `Dictionary` every frame using `new` is way more expensive than just `Clear`ing an existing one, so try reusing collections whenever you can.

### GetComponents(results) is a thing!
This is closely related to the previous tip, as it involves reusing collections. As I only recently discovered, there exists an overload of `GameObject.GetComponents` that accepts a `List<Component>` as an argument, which will be used as the output buffer for the method (in this overload, the method returns the number of components that were found). This is super useful performance-wise, as this method overload *does not allocate at all*. For this reason, it can even be faster than a plain `GetComponent()`<sup>[your mileage may vary: always double-check with the Profiler]</sup>!

Here is an example on how to use this:
```
// With the "usual" GetComponents():
void DoSomethingOnEveryFooComponent(GameObject obj) {
	var components = obj.GetComponents<Foo>();
	foreach (var comp in components)
		DoSomething(comp);
}

//----------------------
// With the non-allocating overload:
readonly List<Foo> fooBuffer = new List<Foo>(); // class variable

void DoSomethingOnEveryFooComponent(GameObject obj) {
	fooBuffer.Clear();
	int nFound = obj.GetComponents(fooBuffer);
	for (int i = 0; i < nFound; ++i)
		DoSomething(fooBuffer[i]);
}
```

Slightly more verbose, but the performance gain is more than worth it!

### Don't use enum-keyed Dictionaries!
Every time you find yourself defining a Dictionary with an enum type as the key type, take a step back and think if you can just use a plain array instead. Since an enum is just an integer value constrained within a (usually small) range, indexing an array via the enum value is usually a very viable solution which requires almost no more effort than a Dictionary and it's much more efficient.
The efficiency comes not only from the avoided hash calculation every time you need to access an element, but also from the fact that iterating through an array does not allocate, while iterating a Dictionary does.

In the simplest case, where you don't explicitly define the enumeration values, using an array as an enum-keyed Dictionary is trivial:
```
// Creation
readonly ValueType[] enumDictionary = new ValueType[Enum.GetValues(typeof(MyEnum)).Length];

// Access
var value = enumDictionary[(int)enumValue];
```

Even if you're using a "Flags" enum, things don't get much more complicated: you just need a helper function to convert your enum value from its "flag" form to its "index" form. This is done simply by extracting the Log2 of the flag value. 

```
// Note: creation is same as before

[Flags]
enum MyEnum {
	None  = 0,
	FlagA = 1 << 0,
	FlagB = 1 << 1,
	FlagC = 1 << 2,
}

// n must be a power of 2
public static int FastLog2(int n) {
	for (int i = 0; i < 32; ++i)
		if ((1 << i) == n)
			return i;

	Debug.LogAssertion(n + " is not a power of 2!");
	return 0;
}

// Access
var value = enumDictionary[FastLog2((int)enumValue)];
```

Here I used a super-simple function that assumes its input is a power of 2. It does not allocate and its execution time is totally negligible. The `FastLog2` function will convert the enum flag values an index from 0 to N-1, where N is the number of values in the enumeration.

### Comment-out (or delete) Debug.Log when you don't need it anymore
`Debug.Log` is a super-useful helper when doing Unity scripting, but it has the tendency to remain there even after you're not really needing it anymore because "one never knows". 
Unfortunately, Debug.Log tends to slow things down a lot, especially when allocating new strings every time. The performance penalty due to string allocation is still there even when logging is disabled, so all those Debug.Logs are going to impact your release build as well!

In general, try to keep your "live" debugging spots to a minimum, and comment them out as soon as you don't need them anymore. If the need arises, you can always go uncomment them later :-)


---

There are usually lots of spots where you can gain a noticeable performance gain when you go look for them. When you go and try to optimize your code (and you should do that on a regular basis!), my advice is to open the Profiler, hit Record and play your game. Then look through the Profiler output. Familiarize with it, learn how to use it effectively and it will be an invaluable tool for you in the long run.
