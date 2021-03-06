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
#end
Class tlEC_Amount Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentamount = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_Amount = New tlEC_Amount
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#end
Class tlEC_Life Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentlife = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_Life = New tlEC_Life
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_LifeVariation Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentlifevariation = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_LifeVariation = New tlEC_LifeVariation
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_AmountVariation Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentamountvariation = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_AmountVariation = New tlEC_AmountVariation
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_BaseSizeX Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentbasesizex = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_BaseSizeX = New tlEC_BaseSizeX
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_BaseSizeY Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentbasesizey = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_BaseSizeY = New tlEC_BaseSizeY
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_BaseSpeed Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentbasespeed = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_BaseSpeed = New tlEC_BaseSpeed
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_BaseSpin Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentbasespin = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_BaseSpin = New tlEC_BaseSpin
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_BaseWeight Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentbaseweight = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_BaseWeight = New tlEC_BaseWeight
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_Splatter Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentsplatter = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_Splatter = New tlEC_Splatter
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_SizeXVariation Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentsizexvariation = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_SizeXVariation = New tlEC_SizeXVariation
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_SizeYVariation Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentsizeyvariation = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_SizeYVariation = New tlEC_SizeYVariation
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_DirectionVariation Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentdirectionvariation = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_DirectionVariation = New tlEC_DirectionVariation
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_VelocityVariation Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentvelocityvariation = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_VelocityVariation = New tlEC_VelocityVariation
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_SpinVariation Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentspinvariation = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_SpinVariation = New tlEC_SpinVariation
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_WeightVariation Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		emitter.currentweightvariation = Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_WeightVariation = New tlEC_WeightVariation
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_ScaleXOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
		
	Method ControlParticle(p:tlParticle) Override
		p.ScaleVector = New tlVector2((Get_Overtime(p.Age, p.lifetime) * p.gsizex * p.width) / p.sprite.Width, p.ScaleVector.y)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_ScaleXOvertime = New tlEC_ScaleXOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
		
End
#Rem monkeydoc @hidden
#end
Class tlEC_ScaleYOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		p.ScaleVector = New tlVector2(p.ScaleVector.x, (Get_Overtime(p.Age, p.lifetime) * p.gsizey * p.height) / p.sprite.Height)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_ScaleYOvertime = New tlEC_ScaleYOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_UniformScale Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		local scale:float = (Get_Overtime(p.Age, p.lifetime) * p.gsizex * p.width) / p.sprite.Width
		p.ScaleVector = New tlVector2(scale, scale)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_UniformScale = New tlEC_UniformScale
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#end
Class tlEC_VelocityOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		p.speed = Get_Overtime(p.Age, p.lifetime) * p.basespeed
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_VelocityOvertime = New tlEC_VelocityOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_GlobalVelocity Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		p.speed *= Get(effect.CurrentFrame)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_GlobalVelocity = New tlEC_GlobalVelocity
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#end
Class tlEC_StretchOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		If p.gravity
			If p.speed
				p.speed_vec.x = p.speed_vec.x * tp_CURRENT_UPDATE_TIME
				p.speed_vec.y = p.speed_vec.y * tp_CURRENT_UPDATE_TIME - p.gravity
			Else
				p.speed_vec.x = 0
				p.speed_vec.y = -p.gravity
			End If
			If emitter.Uniform
				p.ScaleVector = New tlVector2(p.ScaleVector.x, (emitter.scalex_component.Get_Overtime(p.Age, p.lifetime) * p.gsizex * (p.width + (GetDistance(0, 0, p.speed_vec.x, p.speed_vec.y) * Get_Overtime(p.Age, p.lifetime) * effect.currentstretch))) / p.sprite.Width)
			Else
				p.ScaleVector = New tlVector2(p.ScaleVector.x, (emitter.scaley_component.Get_Overtime(p.Age, p.lifetime) * p.gsizey * (p.height + (GetDistance(0, 0, p.speed_vec.x, p.speed_vec.y) * Get_Overtime(p.Age, p.lifetime) * effect.currentstretch))) / p.sprite.Height)
			End If
		Else
			If emitter.Uniform
				p.ScaleVector = New tlVector2(p.ScaleVector.x, (emitter.scalex_component.Get_Overtime(p.Age, p.lifetime) * p.gsizex * (p.width + (Abs(p.speed) * Get_Overtime(p.Age, p.lifetime) * effect.currentstretch))) / p.sprite.Width)
			Else
				p.ScaleVector = New tlVector2(p.ScaleVector.x, (emitter.scaley_component.Get_Overtime(p.Age, p.lifetime) * p.gsizey * (p.height + (Abs(p.speed) * Get_Overtime(p.Age, p.lifetime) * effect.currentstretch))) / p.sprite.Height)
			End If
		EndIf
		If p.ScaleVector.y < p.ScaleVector.x p.ScaleVector = New tlVector2(p.ScaleVector.x, p.ScaleVector.x)
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_StretchOvertime = New tlEC_StretchOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#end
Class tlEC_AlphaOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		If emitter.AlphaRepeat > 1
			p.rptageA += tp_UPDATE_TIME * emitter.AlphaRepeat
			p.Alpha = Get_Overtime(p.rptageA, p.lifetime) * effect.currentalpha
			If p.rptageA > p.lifetime And p.acycles < emitter.AlphaRepeat
				p.rptageA -= p.lifetime
				p.acycles += 1
			End If
		Else
			p.Alpha = Get_Overtime(p.Age, p.lifetime) * effect.currentalpha
		End If
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_AlphaOvertime = New tlEC_AlphaOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_RedOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		If emitter.ColorRepeat > 1
			p.rptageC += tp_UPDATE_TIME * emitter.ColorRepeat
			p.Red = Get_Overtime(p.rptageC, p.lifetime)
			If p.rptageC > p.lifetime And p.ccycles < emitter.ColorRepeat
				p.rptageC-=p.lifetime
				p.ccycles+=1
			End If
		Else
			p.Red = Get_Overtime(p.Age, p.lifetime)
		End If
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_RedOvertime = New tlEC_RedOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End

#Rem monkeydoc @hidden
#end
Class tlEC_GreenOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		If emitter.ColorRepeat > 1
			p.Green = Get_Overtime(p.rptageC, p.lifetime)
		Else
			p.Green = Get_Overtime(p.Age, p.lifetime)
		End If
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_GreenOvertime = New tlEC_GreenOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_BlueOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		If emitter.ColorRepeat > 1
			p.Blue = Get_Overtime(p.rptageC, p.lifetime)
		Else
			p.Blue = Get_Overtime(p.Age, p.lifetime)
		End If
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_BlueOvertime = New tlEC_BlueOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_DirectionOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		If p.directionlocked
			'p.direction = 90
			If effect.EffectClass = tlLINE_EFFECT
				If effect.DistanceSetByLife
					Local life:Float = p.Age / p.lifetime
					p.LocalVector = New tlVector2((life * effect.currentareawidth) - effect.HandleVector.x, p.LocalVector.y)
				Else
					Select effect.EndBehaviour
						Case tlEND_KILL
							If p.LocalVector.x > effect.currentareawidth - effect.HandleVector.x Or p.LocalVector.x < 0 - effect.HandleVector.x
								p.Dead = 2
							End If
						Case tlEND_LOOPAROUND
							If p.LocalVector.x > effect.currentareawidth - effect.HandleVector.x
								p.LocalVector = New tlVector2(-effect.HandleVector.x, p.LocalVector.y)
								p.TForm()
								'p.oldx = p.LocalVector.x
								p.OldWorldVector = p.WorldVector.Clone()
							ElseIf p.LocalVector.x < 0 - effect.HandleVector.x
								p.LocalVector = New tlVector2(effect.currentareawidth - effect.HandleVector.x, p.LocalVector.y)
								p.TForm()
								'p.oldx = p.LocalVector.x
								p.OldWorldVector = p.WorldVector.Clone()
							End If
					End Select
				End If
			End If
		Else
			p.direction = Get_Overtime(p.Age, p.lifetime) + p.emissionangle
		End If
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_DirectionOvertime = New tlEC_DirectionOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_DirectionVariationOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		If Not p.directionlocked
			Local dv:Float = p.directionvariaion * Get_Overtime(p.Age, p.lifetime)
			p.timetracker += tp_UPDATE_TIME
			If p.timetracker > tlMOTION_VARIATION_INTERVAL
				p.randomdirection += tlMAX_DIRECTION_VARIATION * Rnd(-dv, dv)
				p.timetracker = 0
				p.randomspeed += tlMAX_VELOCITY_VARIATION * Rnd(-dv, dv)
			End If
			p.direction += p.randomdirection
			If p.emitter.RunVelocity
				p.speed += p.randomspeed
			Else
				p.speed = p.randomspeed
			End If
		End If
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_DirectionVariationOvertime = New tlEC_DirectionVariationOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_SpinOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		p.spin = (Get_Overtime(p.Age, p.lifetime) * p.spinvariation * effect.currentspin) / tp_CURRENT_UPDATE_TIME
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_SpinOvertime = New tlEC_SpinOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End
#Rem monkeydoc @hidden
#end
Class tlEC_WeightOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		p.weight = Get_Overtime(p.Age, p.lifetime) * p.baseweight
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_WeightOvertime = New tlEC_WeightOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End

#Rem monkeydoc @hidden
#end
Class tlEC_FramerateOvertime Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
	End
	
	Method ControlParticle(p:tlParticle) Override
		p.FrameRate = Get_Overtime(p.Age, p.lifetime) * emitter.AnimationDirection
	End
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEC_FramerateOvertime = New tlEC_FramerateOvertime
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method
	
End

#Rem monkeydoc @hidden
#end
Class tlEC_EmissionAngle Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		If Not effect.OverrideEmissionAngle
			emitter.currentemissionangle = Get(effect.CurrentFrame)
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_EmissionAngle = New tlEffectComponent_EmissionAngle
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End
#Rem monkeydoc @hidden
#end
Class tlEC_EmissionRange Extends tlGraphComponent
	Method New()
		Super.New()
	End
		
	Method New(name:String)
		Super.New(name)
	End
	#REM
		bbdoc:Insert your Update code here
	#END
	Method Update() Override
		If Not effect.OverrideEmissionRange
			emitter.currentemissionrange = Get(effect.CurrentFrame)
		End If
	End Method
	
	Method Clone:tlGraphComponent(Effect:tlEffect = Null, Emitter:tlEmitter = Null, CopyNodes:Int = False) Override
		Local copy:tlEffectComponent_EmissionRange = New tlEffectComponent_EmissionRange
		CopyToClone(copy, Effect, Emitter, CopyNodes)
		Return copy
	End Method

End