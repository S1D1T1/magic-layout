 "MagicLayout". a quick & dirty way to set numeric layout values in swiftUI, such as padding. I found it easier than previews. It doesn't do anything more than what previews claim to do 😄  : IE, change values on the fly and see the results.
 
for MacOS/SwiftUI

**Usage:**  
    initialize:  
``` 
       var magicLayoutWindow = MagicLayoutWindow()
```

  layout: use a magic variable (eg, `magic.m1`) for the value you want to set, and it will be wired up to the controls in the floating window. pass it a starting guess
```
	Button("Reset"){}
	.padding(.trailing,magic.m1(20)) // show live controls for trailing padding, starting with 20px.  
	
	Text("I don't know what font size to use")
	.font(.system(size: magic.m2(16))) // make font size adjustable
```


This relies on my public package, "SingleWindow" which creates the floating window, and adds a menu item to open it.
magiclayout isn't set up as a package yet. just grab the source file. SingleWindow is a swift package.
