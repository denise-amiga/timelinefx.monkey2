#rem
	TimelineFX Module by Peter Rigby
	
	Copyright (c) 2012 Peter J Rigby
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.

#END

Namespace timelinefx

Using timelinefx..

#Rem monkeydoc @hidden
#End
Class tlEffectComponent_Amount Extends tlGraphComponent

	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End
	

	Method Update() Override
		If Not effect.OverrideAmount
			If effect.Parent
				effect.currentamount = Get(effect.CurrentFrame) * effect.ParentEmitter.ParentEffect.currentamount
			Else
				effect.currentamount = Get(effect.CurrentFrame)
			End If
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_Amount = New tlEffectComponent_Amount
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_Life Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End


	Method Update() Override
		If Not effect.OverrideLife
			If effect.Parent
				effect.currentlife = Get(effect.CurrentFrame) * effect.ParentEmitter.ParentEffect.currentlife
			Else
				effect.currentlife = Get(effect.CurrentFrame)
			End If
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_Life = New tlEffectComponent_Life
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_SizeX Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideSizeX
			If effect.Parent
				effect.currentsizex = Get(effect.CurrentFrame) * effect.ParentEmitter.ParentEffect.currentsizex
			Else
				effect.currentsizex = Get(effect.CurrentFrame)
			End If
			If effect.Uniform
				effect.currentsizey = effect.currentsizex
			End If
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_SizeX = New tlEffectComponent_SizeX
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_SizeY Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideSizeY
			If effect.Parent
				effect.currentsizey = Get(effect.CurrentFrame) * effect.ParentEmitter.ParentEffect.currentsizey
			Else
				effect.currentsizey = Get(effect.CurrentFrame)
			End If
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_SizeY = New tlEffectComponent_SizeY
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_Velocity Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideVelocity
			If effect.Parent
				effect.currentvelocity = Get(effect.CurrentFrame) * effect.ParentEmitter.ParentEffect.currentvelocity
			Else
				effect.currentvelocity = Get(effect.CurrentFrame)
			End If
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_Velocity = New tlEffectComponent_Velocity
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_Weight Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideWeight
			If effect.Parent
				effect.currentweight = Get(effect.CurrentFrame) * effect.ParentEmitter.ParentEffect.currentweight
			Else
				effect.currentweight = Get(effect.CurrentFrame)
			End If
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_Weight = New tlEffectComponent_Weight
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_Spin Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideSpin
			If effect.Parent
				effect.currentspin = Get(effect.CurrentFrame) * effect.ParentEmitter.ParentEffect.currentspin
			Else
				effect.currentspin = Get(effect.CurrentFrame)
			End If
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_Spin = New tlEffectComponent_Spin
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_Alpha Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideAlpha
			If effect.Parent
				effect.currentalpha = Get(effect.CurrentFrame) * effect.ParentEmitter.ParentEffect.currentalpha
			Else
				effect.currentalpha = Get(effect.CurrentFrame)
			End If
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_Alpha = New tlEffectComponent_Alpha
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_EmissionAngle Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideEmissionAngle
			effect.currentemissionangle = Get(effect.CurrentFrame)
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_EmissionAngle = New tlEffectComponent_EmissionAngle
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_EmissionRange Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideEmissionRange
			effect.currentemissionrange = Get(effect.CurrentFrame)
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_EmissionRange = New tlEffectComponent_EmissionRange
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_AreaWidth Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideAreaSize
			effect.currentareawidth = Get(effect.CurrentFrame)
			If effect.HandleCenter effect.HandleVector = New tlVector2(effect.currentareawidth *.5, effect.HandleVector.y)
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_AreaWidth = New tlEffectComponent_AreaWidth
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_AreaHeight Extends tlGraphComponent 
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideAreaSize
			effect.currentareaheight = Get(effect.CurrentFrame)
			If effect.HandleCenter effect.HandleVector = New tlVector2(effect.HandleVector.x, effect.currentareaheight *.5)
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_AreaHeight = New tlEffectComponent_AreaHeight
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_Angle Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideAngle
			effect.LocalRotation = Interpolate(effect.Age)
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_Angle = New tlEffectComponent_Angle
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_Stretch Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideStretch
			If effect.Parent
				effect.currentstretch = Get(effect.CurrentFrame) * effect.ParentEmitter.ParentEffect.currentstretch
			Else
				effect.currentstretch = Get(effect.CurrentFrame)
			End If
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_Stretch = New tlEffectComponent_Stretch
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#End
Class tlEffectComponent_GlobalZoom Extends tlGraphComponent
	Method New()
		Super.New()
	End	
	Method New(name:String)
		Super.New(name)
	End

	Method Update() Override
		If Not effect.OverrideGlobalZoom
			If effect.Parent
				effect.currentglobalzoom = Get(effect.CurrentFrame) * effect.ParentEmitter.ParentEffect.currentglobalzoom
			Else
				effect.currentglobalzoom = Get(effect.CurrentFrame)
			End If
			effect.Zoom = effect.currentglobalzoom
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_GlobalZoom = New tlEffectComponent_GlobalZoom
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End