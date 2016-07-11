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

Namespace timelinefx.gameobject

Using timelinefx..

Class tlFXObject extends tlGameObject
	
	Private
	
	Field path:String
	
	'common settings
	Field handlecenter:Int
	Field dontinheritzoom:Int
		
	Public
	
	'Common temp atribute vaues
	Field currentamount:Float
	Field currentlife:Float

	Method New()
	End
	
	Property CurrentAmount:Float()
		Return currentamount
	Setter(value:Float) 
		currentamount = value
	End
	
	Property CurrentLife:Float() 
		Return currentlife
	Setter(value:Float) 
		currentlife = value
	End
	
	Property Path:String() 
		Return path
	Setter(value:String)
		path = value
	End	
	
	Property HandleCenter:Int() 
		Return handlecenter
	Setter(value:Int)
		handlecenter = value
	End
	
	Method DoNotInheritZoom(v:Int = True)
		dontinheritzoom = v
	End Method
	
	Method TForm()

		'set the Matrix if it is relative to the Parent
		If Relative
			Matrix = New tlMatrix2(Cos(LocalRotation), Sin(LocalRotation), -Sin(LocalRotation), Cos(LocalRotation))
		End If
		
		'calculate where the particle is in the world
		If Parent And Relative
			If Not dontinheritzoom Zoom = Parent.Zoom
			Matrix = Matrix.Transform(Parent.Matrix)
			RotateVector = Parent.Matrix.TransformVector(LocalVector)
			If Zoom = 1
				WorldVector = Parent.WorldVector + RotateVector
			Else
				WorldVector = (Parent.WorldVector + RotateVector) * Zoom
			End If
			WorldRotation = Parent.WorldRotation + LocalRotation
		Else
			WorldRotation = LocalRotation
			WorldVector = LocalVector.Clone()
		End If

		WorldScaleVector = ScaleVector.Clone()

	End Method

	
End