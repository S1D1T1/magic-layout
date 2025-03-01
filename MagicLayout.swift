//
//  MagicLayout.swift
//
//  Created 7/11/24.
//
// ⓒ 2024 tafkad


import Foundation
import SwiftUI
import AppKit
import SingleWindow


/*

 Magic Layout variable window.
 MacOS / SwiftUI

 + Appkit for separate window
 ** Relies on SingleWindow:
 https://github.com/S1D1T1/singlewindow

 Usage:
 SomeView()
 .padding(.leading,magic.m1(10))

use it to tweak font size, padding, any Float value
 Use it to set a color.

 removing magicLayout for production build:

 in my project it's a single line of code:

 #if magicLayou
  var magicLayoutWindow = MagicLayoutWindow()
 #endif

 */

@Observable class MagicLayoutWindow {
  var window:SingleWindow

  init() {
    let window = makeSingleWindow(
      title:"Magic Layout", // must supply title to get in the Windows Menu
      //shortcutString: "m",
      rect: NSRect(x: 50, y: 50, width: 360, height: 180))
    {
      MagicLayoutView(layoutVars: magic)
    }

    window.myWin.center()
    window.myWin.alphaValue = 0.8

    window.myWin.level = NSWindow.Level.floating
    window.myWin.titlebarAppearsTransparent = true
    window.myWin.title = "" // this is the title bar title.
    window.myWin.isMovableByWindowBackground = true
    window.myWin.styleMask =  [.fullSizeContentView,.closable,.miniaturizable,.nonactivatingPanel, .resizable,.titled]
    self.window = window

    // start off closed
    self.window.close()
  }
}

struct MagicLayoutView : View {
  @State var layoutVars:MagicLayoutVars

  var body: some View {
    Text("Magic layout vars").font(.title2)
    VStack{
      VStack {
        VarView(mVar: $layoutVars.mv1.value, title: "magic 1")
        VarView(mVar: $layoutVars.mv2.value, title: "magic 2")
      }
      .width(75)
      ColorPicker("Color 1", selection: $layoutVars.color1)
    }
    .padding(100)
  }
}

struct VarView : View {
  @Binding var mVar:Float
  var title:String

  var body: some View {
    HStack{
      TextField(title, value: $mVar,format:.number)
      Stepper(value: $mVar){Text("")}
    }
  }
}

@Observable class MagicLayoutVars {

  var mv1 = MagicVar()
  var mv2 = MagicVar()
  var mv3 = MagicVar()
  var color1 = Color.white
  var setColor = false

  // pass an initial value
  func m1(_ initialValue:CGFloat) -> CGFloat {
    mv1.getValue(initialValue)
  }

  func m2(_ initialValue:CGFloat) -> CGFloat {
    mv2.getValue(initialValue)
  }

  func m3(_ initialValue:CGFloat) -> CGFloat {
    mv3.getValue(initialValue)
  }

  func c1(_ initialValue:Color) -> Color {
    if !setColor {
      setColor = true
      color1 = initialValue
    }
    return color1
    }
  }


@Observable class MagicVar {
  var value:Float = 0
  var valueSet = false

  func getValue(_ initialValue:CGFloat) -> CGFloat {
    if !valueSet {
      valueSet = true
      value = Float(initialValue)
    }
    return CGFloat(value)
  }
}

let magic = MagicLayoutVars()
