#rem
	Copyright (c) 2010 Peter J Rigby
	
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

#REM monkeydoc Load a TimelineFX Library
	In order to load in an effects library, you need to do a little preparation first. Monkey 2 applications currently cannot unpack zip files to memory so it's easier to just unzip the effect file
	to your assets folder.

	Export the effects library from the TimelineFX editor and then unpack the .zip file into a folder of the same name inside the "assets" folder of your monkey app. For example, if you have an ZIP file called explosions, then unpack this
	into your assets folder in a folder called explosions. So the folder structure should be
	
	assets/explosions/
	
	Once that is done you can load the effects with:
	
	@example
	Local MyEffects:tlEffectsLibrary
	MyEffects = LoadEffects("asset::explosions")
	@end
#END
Function LoadEffects:tlEffectsLibrary(filename:String)

	local xmldoc:XMLParser = XMLParser.ParseFile(filename + "/data.xml")
	Local library:tlEffectsLibrary = new tlEffectsLibrary
	
	For Local xmleffect:XMLElement = eachin xmldoc.Root.Children
		if xmleffect.Name = "SHAPES"
			For Local xmlshape:XMLElement = eachin xmleffect.Children
				Local shape:tlShape
				Local url:String = StripDir(xmlshape.GetAttribute("URL").Replace("\", "/"))
				'url = url.Replace(".tpa", ".png")

				shape = LoadShape(filename + "/" + url, int(xmlshape.GetAttribute("WIDTH")), int(xmlshape.GetAttribute("HEIGHT")), int(xmlshape.GetAttribute("FRAMES")))

				If shape.GetImage(0) = Null
					Print url
				EndIf
				
				shape.LargeIndex = int(xmlshape.GetAttribute("INDEX"))
				
				library.AddShape(shape)
			Next
		End If
	Next
	
	For Local xmleffect:XMLElement = eachin xmldoc.Root.Children
		Select xmleffect.Name
			Case "EFFECT"
				Local effect:tlEffect = LoadEffectXMLTree(xmleffect, library)
				library.AddEffect(effect)
				effect.Directory = New StringMap<tlGameObject>
				effect.AddEffectToDirectory(effect)
				effect.AddEffect(effect)
				effect.CompileAll()
			Case "FOLDER"
				LoadFolderXMLTree(xmleffect, library)
		End
	Next
	
	Return library
	
End

Private
Function LoadEffectXMLTree:tlEffect(effectschild:XMLElement, effectslib:tlEffectsLibrary, Parent:tlEmitter = Null, Folderpath:String = "")
	Local e:tlEffect = New tlEffect
	Local ec:tlAttributeNode
	
	e.EffectClass = Cast<Int>(effectschild.GetAttribute("TYPE"))
	e.EmitatPoints = Cast <Int>(effectschild.GetAttribute("EMITATPOINTS"))
	e.MaxGX = Cast <Int>(effectschild.GetAttribute("MAXGX"))
	e.MaxGY = Cast <Int>(effectschild.GetAttribute("MAXGY"))
	e.EmissionType = Cast <Int>(effectschild.GetAttribute("EMISSION_TYPE"))
	e.EllipseArc = DegRad(Cast <Float>(effectschild.GetAttribute("ELLIPSE_ARC")))
	e.EffectLength = Cast <Int>(effectschild.GetAttribute("EFFECT_LENGTH"))
	e.Uniform = Cast <Int>(effectschild.GetAttribute("UNIFORM"))
	e.Name = effectschild.GetAttribute("NAME")
	e.HandleCenter = Cast <Int>(effectschild.GetAttribute("HANDLE_CENTER"))
	e.SetHandle(Cast <Int>(effectschild.GetAttribute("HANDLE_X")), Cast <Int>(effectschild.GetAttribute("HANDLE_Y")))
	e.TraverseEdge = Cast <Int>(effectschild.GetAttribute("TRAVERSE_EDGE"))
	e.EndBehaviour = Cast <Int>(effectschild.GetAttribute("END_BEHAVIOUR"))
	e.DistanceSetByLife = Cast <Int>(effectschild.GetAttribute("DISTANCE_SET_BY_LIFE"))
	e.ReverseSpawnDirection = Cast <Int>(effectschild.GetAttribute("REVERSE_SPAWN_DIRECTION"))
	e.ParentEmitter = Parent
	If e.ParentEmitter
		e.Path = e.ParentEmitter.Path + "/" + e.Name
	Else
		e.Path = Folderpath + e.Name
	End If
	Local effectchildren:List<XMLElement> = effectschild.Children
	'Temp attribute node lists
	Local amount:List<tlAttributeNode> = New List<tlAttributeNode>
	Local life:List<tlAttributeNode> = New List<tlAttributeNode>
	Local sizex:List<tlAttributeNode> = New List<tlAttributeNode>
	Local sizey:List<tlAttributeNode> = New List<tlAttributeNode>
	Local velocity:List<tlAttributeNode> = New List<tlAttributeNode>
	Local weight:List<tlAttributeNode> = New List<tlAttributeNode>
	Local spin:List<tlAttributeNode> = New List<tlAttributeNode>
	Local alpha:List<tlAttributeNode> = New List<tlAttributeNode>
	Local emissionangle:List<tlAttributeNode> = New List<tlAttributeNode>
	Local emissionrange:List<tlAttributeNode> = New List<tlAttributeNode>
	Local areawidth:List<tlAttributeNode> = New List<tlAttributeNode>
	Local areaheight:List<tlAttributeNode> = New List<tlAttributeNode>
	Local angle:List<tlAttributeNode> = New List<tlAttributeNode>
	Local stretch:List<tlAttributeNode> = New List<tlAttributeNode>
	Local globalzoom:List<tlAttributeNode> = New List<tlAttributeNode>
	For Local effectchild:XMLElement = EachIn effectchildren
		Select effectchild.Name
			Case "ANIMATION_PROPERTIES"
				e.Frames = Cast <Int>(effectchild.GetAttribute("FRAMES"))
				e.AnimWidth = Cast <Int>(effectchild.GetAttribute("WIDTH"))
				e.AnimHeight = Cast <Int>(effectchild.GetAttribute("HEIGHT"))
				e.AnimX = Cast <Int>(effectchild.GetAttribute("X"))
				e.AnimY = Cast <Int>(effectchild.GetAttribute("Y"))
				e.Seed = Cast <Int>(effectchild.GetAttribute("SEED"))
				e.Looped = Cast <Int>(effectchild.GetAttribute("LOOPED"))
				e.Zoom = Cast <Float>(effectchild.GetAttribute("ZOOM"))
				e.FrameOffset = Cast <Int>(effectchild.GetAttribute("FRAME_OFFSET"))
			Case "AMOUNT"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), Cast <Float>(effectchild.GetAttribute("VALUE")))
				amount.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "LIFE"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), Cast <Float>(effectchild.GetAttribute("VALUE")))
				life.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "SIZEX"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), Cast <Float>(effectchild.GetAttribute("VALUE")))
				sizex.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "SIZEY"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), Cast <Float>(effectchild.GetAttribute("VALUE")))
				sizey.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "VELOCITY"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), Cast <Float>(effectchild.GetAttribute("VALUE")))
				velocity.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "WEIGHT"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), Cast <Float>(effectchild.GetAttribute("VALUE")))
				weight.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "SPIN"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), Cast <Float>(effectchild.GetAttribute("VALUE")))
				spin.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "ALPHA"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), Cast <Float>(effectchild.GetAttribute("VALUE")))
				alpha.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "EMISSIONANGLE"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), DegRad(Cast <Float>(effectchild.GetAttribute("VALUE"))))
				emissionangle.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "EMISSIONRANGE"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), DegRad(Cast <Float>(effectchild.GetAttribute("VALUE"))))
				emissionrange.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "AREA_WIDTH"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), Cast <Float>(effectchild.GetAttribute("VALUE")))
				areawidth.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "AREA_HEIGHT"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), Cast <Float>(effectchild.GetAttribute("VALUE")))
				areaheight.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "ANGLE"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), DegRad(Cast <Float>(effectchild.GetAttribute("VALUE"))))
				angle.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "STRETCH"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), Cast <Float>(effectchild.GetAttribute("VALUE")))
				stretch.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
								Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
								Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
								Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "GLOBAL_ZOOM"
				ec = New tlAttributeNode(Cast <Float>(effectchild.GetAttribute("FRAME")), Cast <Float>(effectchild.GetAttribute("VALUE")))
				globalzoom.AddLast(ec)
				Local attlist:List<XMLElement> = effectchild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),  
								Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),  
								Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),  
								Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
		End Select
	Next
	'create the necessary components
	If amount.Count() > 1 Or e.ParentHasGraph("Amount")
		Local component:tlEffectComponent_Amount = New tlEffectComponent_Amount("Amount")
		component.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, amount, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
		e.CurrentAmount = amount.First.value
	ElseIf amount.Count() = 1
		e.CurrentAmount = amount.First.value
		If e.ParentEmitter
			e.CurrentAmount *= e.ParentEmitter.ParentEffect.CurrentAmount
		End If
	End If
	If life.Count() > 1 Or e.ParentHasGraph("Life")
		Local component:tlEffectComponent_Life = New tlEffectComponent_Life("Life")
		component.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, life, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
		e.CurrentAmount = life.First.value
	ElseIf life.Count() = 1
		e.CurrentLife = life.First.value
		If e.ParentEmitter
			e.CurrentLife*=e.ParentEmitter.ParentEffect.CurrentLife
		End If
	End If
	If sizex.Count() > 1 Or e.ParentHasGraph("SizeX")
		Local component:tlEffectComponent_SizeX = New tlEffectComponent_SizeX("SizeX")
		component.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, sizex, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
		e.CurrentSizeY = sizex.First.value
	ElseIf sizex.Count() = 1
		e.CurrentSizeX = sizex.First.value
		If e.Uniform
			e.CurrentSizeY = e.CurrentSizeX
		End If
		If e.ParentEmitter
			e.CurrentSizeX*=e.ParentEmitter.ParentEffect.CurrentSizeX
		End If
	End If
	If Not e.Uniform Or e.ParentHasGraph("SizeX")
		If sizey.Count() > 1
			Local component:tlEffectComponent_SizeY = New tlEffectComponent_SizeY("SizeX")
			component.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, sizey, tlNORMAL_GRAPH, e)
			e.AddComponent(component)
			e.CurrentSizeY = sizey.First.value
		ElseIf sizey.Count() = 1
			e.CurrentSizeY = sizey.First.value
			If e.ParentEmitter
				e.CurrentSizeY*=e.ParentEmitter.ParentEffect.CurrentSizeY
			End If
		End If
	End If
	If velocity.Count() > 1 Or e.ParentHasGraph("Velocity")
		Local component:tlEffectComponent_Velocity = New tlEffectComponent_Velocity("Velocity")
		component.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, velocity, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
		e.CurrentVelocity = velocity.First.value
	ElseIf velocity.Count() = 1
		e.CurrentVelocity = velocity.First.value
		If e.ParentEmitter
			e.CurrentVelocity*=e.ParentEmitter.ParentEffect.CurrentVelocity
		End If
	End If
	If weight.Count() > 1 Or e.ParentHasGraph("Weight")
		Local component:tlEffectComponent_Weight = New tlEffectComponent_Weight("Weight")
		component.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, weight, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
		e.CurrentWeight = weight.First.value
	ElseIf weight.Count() = 1
		e.CurrentWeight = weight.First.value
		If e.ParentEmitter
			e.CurrentWeight*=e.ParentEmitter.ParentEffect.CurrentWeight
		End If
	End If
	If spin.Count() > 1 Or e.ParentHasGraph("Spin")
		Local component:tlEffectComponent_Spin = New tlEffectComponent_Spin("Spin")
		component.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, spin, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
		e.CurrentSpin = spin.First.value
	ElseIf spin.Count() = 1
		e.CurrentSpin = spin.First.value
		If e.ParentEmitter
			e.CurrentSpin*=e.ParentEmitter.ParentEffect.CurrentSpin
		End If
	End If
	If alpha.Count() > 1 Or e.ParentHasGraph("Alpha")
		Local component:tlEffectComponent_Alpha = New tlEffectComponent_Alpha("Alpha")
		component.InitGraph(0, 1, alpha, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
		e.CurrentAlpha = alpha.First.value
	ElseIf alpha.Count() = 1
		e.CurrentAlpha = alpha.First.value
		If e.ParentEmitter
			e.CurrentAlpha*=e.ParentEmitter.ParentEffect.CurrentAlpha
		End If
	End If
	If emissionangle.Count() > 1
		Local component:tlEffectComponent_EmissionAngle = New tlEffectComponent_EmissionAngle("EmissionAngle")
		component.InitGraph(tlANGLE_MIN, tlANGLE_MAX, emissionangle, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
	ElseIf emissionangle.Count() = 1
		e.CurrentEmissionAngle = emissionangle.First.value
	End If
	If emissionrange.Count() > 1
		Local component:tlEffectComponent_EmissionRange = New tlEffectComponent_EmissionRange("EmissionRange")
		component.InitGraph(tlEMISSION_RANGE_MIN, tlEMISSION_RANGE_MAX, emissionrange, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
	ElseIf emissionrange.Count() = 1
		e.CurrentEmissionRange = emissionrange.First.value 
	End If
	If areawidth.Count() > 1
		Local component:tlEffectComponent_AreaWidth = New tlEffectComponent_AreaWidth("AreaWidth")
		component.InitGraph(tlDIMENSIONS_MIN, tlDIMENSIONS_MAX, areawidth, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
	ElseIf areawidth.Count() = 1
		e.CurrentAreaWidth = areawidth.First.value
	End If
	If areaheight.Count() > 1
		Local component:tlEffectComponent_AreaHeight = New tlEffectComponent_AreaHeight("AreaHeight")
		component.InitGraph(tlDIMENSIONS_MIN, tlDIMENSIONS_MAX, areaheight, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
	ElseIf areaheight.Count() = 1
		e.CurrentAreaHeight = areaheight.First.value
	End If
	If e.HandleCenter And e.EffectClass <> tlPOINT_EFFECT
		e.HandleVector = New tlVector2(e.CurrentAreaWidth / 2, e.CurrentAreaHeight / 2)
	ElseIf e.HandleCenter
		e.HandleVector = New tlVector2(0, 0)
	End If
	If angle.Count() > 1
		Local component:tlEffectComponent_Angle = New tlEffectComponent_Angle("Angle")
		component.InitGraph(tlANGLE_MIN, tlANGLE_MAX, angle, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
	ElseIf angle.Count() = 1
		e.LocalRotation = angle.First.value
	End If
	If stretch.Count() > 1 Or e.ParentHasGraph("Stretch")
		Local component:tlEffectComponent_Stretch = New tlEffectComponent_Stretch("Stretch")
		component.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, stretch, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
		e.CurrentStretch = stretch.First.value
	ElseIf stretch.Count() = 1
		e.CurrentStretch = stretch.First.value
		If e.ParentEmitter
			e.CurrentStretch*=e.ParentEmitter.ParentEffect.CurrentStretch
		End If
	End If
	If globalzoom.Count() > 1 Or e.ParentHasGraph("GlobalZoom")
		Local component:tlEffectComponent_GlobalZoom = New tlEffectComponent_GlobalZoom("GlobalZoom")
		component.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, globalzoom, tlNORMAL_GRAPH, e)
		e.AddComponent(component)
		e.CurrentGlobalZoom = globalzoom.First.value
	ElseIf globalzoom.Count() = 1
		e.CurrentGlobalZoom = globalzoom.First.value
		If e.ParentEmitter
			e.CurrentGlobalZoom*=e.ParentEmitter.ParentEffect.CurrentGlobalZoom
		End If
		e.Zoom = e.CurrentGlobalZoom
	Else
		e.CurrentGlobalZoom = 1
		If e.ParentEmitter
			e.CurrentGlobalZoom*=e.ParentEmitter.ParentEffect.CurrentGlobalZoom
		End If
		e.Zoom = e.CurrentGlobalZoom
	End If
	For Local effectchild:XMLElement = EachIn effectchildren
		Select effectchild.Name
			Case "PARTICLE"
				e.AddChild(LoadEmitterXMLTree(effectchild, effectslib, e))
		End Select
	Next
	Return e
End Function

Function LoadFolderXMLTree(folderchild:XMLElement, effectslib:tlEffectsLibrary)
	Local effectschildren:= folderchild.Children
	If effectschildren
		For Local effectchild:XMLElement = EachIn effectschildren
			Select effectchild.Name
				Case "EFFECT"
					Local e:tlEffect = LoadEffectXMLTree(effectchild, effectslib, Null, folderchild.GetAttribute("NAME") + "/")
					effectslib.AddEffect(e)
					e.Directory = New StringMap<tlGameObject>
					e.AddEffect(e)
					e.CompileAll()
			End Select
		Next
	End If
End Function
#Rem monkeydoc @hidden
#end
Function LoadEmitterXMLTree:tlEmitter(effectchild:XMLElement, effectslib:tlEffectsLibrary, e:tlEffect)
	Local particlechildren:= effectchild.Children
	Local p:tlEmitter = New tlEmitter
	Local ec:tlAttributeNode
	p.SetHandle(Cast <Int>(effectchild.GetAttribute("HANDLE_X")), Cast <Int>(effectchild.GetAttribute("HANDLE_Y")))
	local blend:= Cast<Int>(effectchild.GetAttribute("BLENDMODE"))
	Select blend
		Case 3
			p.BlendMode = BlendMode.Alpha
		Case 4
			p.BlendMode = BlendMode.Additive
		Default
			p.BlendMode = BlendMode.Alpha
	End
	p.ParticleRelative = Cast <Int>(effectchild.GetAttribute("RELATIVE"))
	p.RandomColor = Cast <Int>(effectchild.GetAttribute("RANDOM_COLOR"))
	p.Layer = Cast <Int>(effectchild.GetAttribute("LAYER"))
	p.SingleParticle = Cast <Int>(effectchild.GetAttribute("SINGLE_PARTICLE"))
	p.Name = effectchild.GetAttribute("NAME")
	p.Animating = Cast <Int>(effectchild.GetAttribute("ANIMATE"))
	p.AnimateOnce = Cast <Int>(effectchild.GetAttribute("ANIMATE_ONCE"))
	p.Frame = Cast <Int>(effectchild.GetAttribute("FRAME"))
	p.RandomStartFrame = Cast <Int>(effectchild.GetAttribute("RANDOM_START_FRAME"))
	p.AnimationDirection = Cast <Int>(effectchild.GetAttribute("ANIMATION_DIRECTION"))
	p.Uniform = Cast <Int>(effectchild.GetAttribute("UNIFORM"))
	p.AngleType = Cast <Int>(effectchild.GetAttribute("ANGLE_TYPE"))
	p.AngleOffset = -DegRad(Cast <Float>(effectchild.GetAttribute("ANGLE_OFFSET")))
	p.LockAngle = Cast <Int>(effectchild.GetAttribute("LOCK_ANGLE"))
	p.AngleRelative = Cast <Int>(effectchild.GetAttribute("ANGLE_RELATIVE"))
	p.UseEffectEmission = Cast <Int>(effectchild.GetAttribute("USE_EFFECT_EMISSION"))
	p.ColorRepeat = Cast <Int>(effectchild.GetAttribute("COLOR_REPEAT"))
	p.AlphaRepeat = Cast <Int>(effectchild.GetAttribute("ALPHA_REPEAT"))
	p.OneShot = Cast <Int>(effectchild.GetAttribute("ONE_SHOT"))
	p.HandleCenter = Cast <Int>(effectchild.GetAttribute("HANDLE_CENTERED"))
	p.GroupParticles = Cast <Int>(effectchild.GetAttribute("GROUP_PARTICLES"))
	If Not p.AnimationDirection
		p.AnimationDirection = 1
	End If
	p.ParentEffect = e
	p.Path = p.ParentEffect.Path + "/" + p.Name
	'Temp attribute node lists
	Local amount:= New List<tlAttributeNode>
	Local life:= New List<tlAttributeNode>
	Local basespeed:= New List<tlAttributeNode>
	Local baseweight:= New List<tlAttributeNode>
	Local basesizex:= New List<tlAttributeNode>
	Local basesizey:= New List<tlAttributeNode>
	Local basespin:= New List<tlAttributeNode>
	Local splatter:= New List<tlAttributeNode>
	Local lifevariation:= New List<tlAttributeNode>
	Local amountvariation:= New List<tlAttributeNode>
	Local velocityvariation:= New List<tlAttributeNode>
	Local weightvariation:= New List<tlAttributeNode>
	Local sizexvariation:= New List<tlAttributeNode>
	Local sizeyvariation:= New List<tlAttributeNode>
	Local spinvariation:= New List<tlAttributeNode>
	Local directionvariation:= New List<tlAttributeNode>
	Local alphaovertime:= New List<tlAttributeNode>
	Local velocityovertime:= New List<tlAttributeNode>
	Local weightovertime:= New List<tlAttributeNode>
	Local scalexovertime:= New List<tlAttributeNode>
	Local scaleyovertime:= New List<tlAttributeNode>
	Local spinovertime:= New List<tlAttributeNode>
	Local direction:= New List<tlAttributeNode>
	Local directionvariationot:= New List<tlAttributeNode>
	Local framerateovertime:= New List<tlAttributeNode>
	Local stretchovertime:= New List<tlAttributeNode>
	Local redovertime:= New List<tlAttributeNode>
	Local greenovertime:= New List<tlAttributeNode>
	Local blueovertime:= New List<tlAttributeNode>
	Local globalvelocity:= New List<tlAttributeNode>
	Local emissionangle:= New List<tlAttributeNode>
	Local emissionrange:= New List<tlAttributeNode>
	For Local particlechild:XMLElement = EachIn particlechildren
		Select particlechild.Name
			Case "ANGLE_TYPE"
				p.AngleType = Cast <Int>(particlechild.GetAttribute("VALUE"))
			Case "ANGLE_OFFSET"
				p.AngleOffset = -DegRad(Cast <Float>(particlechild.GetAttribute("VALUE")))
			Case "LOCK_ANGLE"
				p.LockAngle = Cast <Int>(particlechild.GetAttribute("VALUE"))
			Case "ANGLE_RELATIVE"
				p.AngleRelative = Cast <Int>(particlechild.GetAttribute("VALUE"))
			Case "USE_EFFECT_EMISSION"
				p.UseEffectEmission = Cast <Int>(particlechild.GetAttribute("VALUE"))
			Case "COLOR_REPEAT"
				p.ColorRepeat = Cast <Int>(particlechild.GetAttribute("VALUE"))
			Case "ALPHA_REPEAT"
				p.AlphaRepeat = Cast <Int>(particlechild.GetAttribute("VALUE"))
			Case "ONE_SHOT"
				p.OneShot = Cast <Int>(particlechild.GetAttribute("VALUE"))
			Case "HANDLE_CENTERED"
				p.HandleCenter = Cast <Int>(particlechild.GetAttribute("VALUE"))
			Case "SHAPE_INDEX"
				p.Sprite = effectslib.GetShape(Cast <Int>(particlechild.Value))
			Case "LIFE"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				life.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "AMOUNT"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				amount.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "BASE_SPEED"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				basespeed.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "BASE_WEIGHT"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				baseweight.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "BASE_SIZE_X"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				basesizex.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "BASE_SIZE_Y"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				basesizey.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "BASE_SPIN"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), DegRad(Cast <Float>(particlechild.GetAttribute("VALUE"))))
				basespin.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "SPLATTER"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				splatter.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "LIFE_VARIATION"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				lifevariation.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "AMOUNT_VARIATION"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				amountvariation.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "VELOCITY_VARIATION"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				velocityvariation.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "WEIGHT_VARIATION"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				weightvariation.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "SIZE_X_VARIATION"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				sizexvariation.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "SIZE_Y_VARIATION"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				sizeyvariation.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "SPIN_VARIATION"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), DegRad(Cast <Float>(particlechild.GetAttribute("VALUE"))))
				spinvariation.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "DIRECTION_VARIATION"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				directionvariation.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "ALPHA_OVERTIME"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				alphaovertime.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "VELOCITY_OVERTIME"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				velocityovertime.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "WEIGHT_OVERTIME"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				weightovertime.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "SCALE_X_OVERTIME"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				scalexovertime.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "SCALE_Y_OVERTIME"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				scaleyovertime.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "SPIN_OVERTIME"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				spinovertime.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "DIRECTION"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), DegRad(Cast <Float>(particlechild.GetAttribute("VALUE"))))
				direction.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "DIRECTION_VARIATIONOT"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				directionvariationot.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "FRAMERATE_OVERTIME"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				framerateovertime.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "STRETCH_OVERTIME"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				stretchovertime.AddLast(ec)
				Local attlist:List<XMLElement> = particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
								Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
								Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
								Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "RED_OVERTIME"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")) / 255.0)
				redovertime.AddLast(ec)
			Case "GREEN_OVERTIME"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")) / 255.0)
				greenovertime.AddLast(ec)
			Case "BLUE_OVERTIME"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")) / 255.0)
				blueovertime.AddLast(ec)
			Case "GLOBAL_VELOCITY"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), Cast <Float>(particlechild.GetAttribute("VALUE")))
				globalvelocity.AddLast(ec)
				Local attlist:= particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "EMISSION_ANGLE"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), DegRad(Cast <Float>(particlechild.GetAttribute("VALUE"))))
				emissionangle.AddLast(ec)
				Local attlist:= particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "EMISSION_RANGE"
				ec = New tlAttributeNode(Cast <Float>(particlechild.GetAttribute("FRAME")), DegRad(Cast <Float>(particlechild.GetAttribute("VALUE"))))
				emissionrange.AddLast(ec)
				Local attlist:= particlechild.Children
				If attlist
					For Local attchild:XMLElement = EachIn attlist
						Select attchild.Name
							Case "CURVE"
								ec.SetCurvePoints(Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("LEFT_CURVE_POINT_Y")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_X")),
									Cast <Float>(attchild.GetAttribute("RIGHT_CURVE_POINT_Y")))
						End Select
					Next
				End If
			Case "EFFECT"
				p.AddEffect(LoadEffectXMLTree(particlechild, effectslib, p))
		End Select
	Next
	'create the necessary components
	If amount.Count() > 1
		Local component:tlEC_Amount = New tlEC_Amount("Amount")
		component.InitGraph(tlAMOUNT_MIN, tlAMOUNT_MAX, amount, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf amount.Count() = 1
		p.CurrentAmount = amount.First.value
	End If
	If amountvariation.Count() > 1
		Local component:tlEC_AmountVariation = New tlEC_AmountVariation("AmountVariation")
		component.InitGraph(tlAMOUNT_MIN, tlAMOUNT_MAX, amountvariation, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf amountvariation.Count() = 1
		p.currentamountvariation = amountvariation.First.value
	End If
	If life.Count() > 1
		Local component:tlEC_Life = New tlEC_Life("Life")
		component.InitGraph(tlLIFE_MIN, tlLIFE_MAX, life, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf life.Count() = 1
		p.currentlife = life.First.value
	End If
	If lifevariation.Count() > 1
		Local component:tlEC_LifeVariation = New tlEC_LifeVariation("LifeVariation")
		component.InitGraph(tlLIFE_MIN, tlLIFE_MAX, lifevariation, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf lifevariation.Count() = 1
		p.currentlifevariation = lifevariation.First.value
	End If
	If basesizex.Count() > 1
		Local component:tlEC_BaseSizeX = New tlEC_BaseSizeX("BaseSizeX")
		component.InitGraph(tlDIMENSIONS_MIN, tlDIMENSIONS_MAX, basesizex, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf basesizex.Count() = 1
		p.currentbasesizex = basesizex.First.value
	End If
	If basesizey.Count() > 1
		Local component:tlEC_BaseSizeY = New tlEC_BaseSizeY("BaseSizeY")
		component.InitGraph(tlDIMENSIONS_MIN, tlDIMENSIONS_MAX, basesizey, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf basesizey.Count() = 1
		p.currentbasesizey = basesizey.First.value
	End If
	If basespeed.Count() > 1
		Local component:tlEC_BaseSpeed = New tlEC_BaseSpeed("BaseSpeed")
		component.InitGraph(tlVELOCITY_MIN, tlVELOCITY_MAX, basespeed, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf basespeed.Count() = 1
		p.currentbasespeed = basespeed.First.value
	End If
	If basespin.Count() > 1
		Local component:tlEC_BaseSpin = New tlEC_BaseSpin("BaseSpin")
		component.InitGraph(tlSPIN_MIN, tlSPIN_MAX, basespin, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf basespin.Count() = 1
		p.currentbasespin = basespin.First.value
	End If
	If baseweight.Count() > 1
		Local component:tlEC_BaseWeight = New tlEC_BaseWeight("BaseWeight")
		component.InitGraph(tlWEIGHT_MIN, tlWEIGHT_MAX, baseweight, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf baseweight.Count() = 1
		p.currentbaseweight = baseweight.First.value
	End If
	If splatter.Count() > 1
		Local component:tlEC_Splatter = New tlEC_Splatter("Splatter")
		component.InitGraph(tlDIMENSIONS_MIN, tlDIMENSIONS_MAX, splatter, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf splatter.Count() = 1
		p.currentsplatter = splatter.First.value
	End If
	If sizexvariation.Count() > 1
		Local component:tlEC_SizeXVariation = New tlEC_SizeXVariation("SizeXVariation")
		component.InitGraph(tlDIMENSIONS_MIN, tlDIMENSIONS_MAX, sizexvariation, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf sizexvariation.Count() = 1
		p.currentsizexvariation = sizexvariation.First.value
	End If
	If sizeyvariation.Count() > 1
		Local component:tlEC_SizeYVariation = New tlEC_SizeYVariation("SizeYVariation")
		component.InitGraph(tlDIMENSIONS_MIN, tlDIMENSIONS_MAX, sizeyvariation, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf sizeyvariation.Count() = 1
		p.currentsizeyvariation = sizeyvariation.First.value
	End If
	If directionvariation.Count() > 1
		Local component:tlEC_DirectionVariation = New tlEC_DirectionVariation("DirectionVariation")
		component.InitGraph(tlDIMENSIONS_MIN, tlDIMENSIONS_MAX, directionvariation, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf directionvariation.Count() = 1
		p.currentdirectionvariation = directionvariation.First.value
	End If
	If velocityvariation.Count() > 1
		Local component:tlEC_VelocityVariation = New tlEC_VelocityVariation("VelocityVariation")
		component.InitGraph(tlVELOCITY_MIN, tlVELOCITY_MAX, velocityvariation, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf velocityvariation.Count() = 1
		p.currentvelocityvariation = velocityvariation.First.value
	End If
	If spinvariation.Count() > 1
		Local component:tlEC_SpinVariation = New tlEC_SpinVariation("SpinVariation")
		component.InitGraph(tlSPIN_VARIATION_MIN, tlSPIN_VARIATION_MAX, spinvariation, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf spinvariation.Count() = 1
		p.currentspinvariation = spinvariation.First.value
	End If
	If weightvariation.Count() > 1
		Local component:tlEC_WeightVariation = New tlEC_WeightVariation("WeightVariation")
		component.InitGraph(tlWEIGHT_VARIATION_MIN, tlWEIGHT_VARIATION_MAX, weightvariation, tlNORMAL_GRAPH, p.ParentEffect, p)
		p.AddComponent(component, False)
	ElseIf weightvariation.Count() = 1
		p.currentweightvariation = weightvariation.First.value
	End If
	If emissionangle.Count() > 1
		Local component:tlEC_EmissionAngle = New tlEC_EmissionAngle("EmissionAngle")
		component.InitGraph(tlANGLE_MIN, tlANGLE_MAX, emissionangle, tlNORMAL_GRAPH, e)
		p.AddComponent(component)
	ElseIf emissionangle.Count() = 1
		p.currentemissionangle = emissionangle.First.value
	End If
	If emissionrange.Count() > 1
		Local component:tlEC_EmissionRange = New tlEC_EmissionRange("EmissionRange")
		component.InitGraph(tlEMISSION_RANGE_MIN, tlEMISSION_RANGE_MAX, emissionrange, tlNORMAL_GRAPH, e)
		p.AddComponent(component)
	ElseIf emissionrange.Count() = 1
		p.currentemissionrange = emissionrange.First.value
	End If
	Local scalexcomponent:tlEC_ScaleXOvertime = New tlEC_ScaleXOvertime("ScaleXOvertime")
	scalexcomponent.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, scalexovertime, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.scalex_component = scalexcomponent
	Local scaleycomponent:tlEC_ScaleYOvertime = New tlEC_ScaleYOvertime("ScaleYOvertime")
	scaleycomponent.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, scaleyovertime, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.scaley_component = scaleycomponent
	Local velocitycomponent:tlEC_VelocityOvertime = New tlEC_VelocityOvertime("VelocityOvertime")
	velocitycomponent.InitGraph(tlVELOCITY_OVERTIME_MIN, tlVELOCITY_OVERTIME_MAX, velocityovertime, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.velocity_component = velocitycomponent
	Local globalvelocitycomponent:tlEC_GlobalVelocity = New tlEC_GlobalVelocity("GlobalVelocity")
	globalvelocitycomponent.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, globalvelocity, tlNORMAL_GRAPH, p.ParentEffect, p)
	p.globalvelocity_component = globalvelocitycomponent
	Local stretchcomponent:tlEC_StretchOvertime = New tlEC_StretchOvertime("StretchOvertime")
	stretchcomponent.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, stretchovertime, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.stretch_component = stretchcomponent
	Local alphacomponent:tlEC_AlphaOvertime = New tlEC_AlphaOvertime("AlphaOvertime")
	alphacomponent.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, alphaovertime, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.alpha_component = alphacomponent
	Local redcomponent:tlEC_RedOvertime = New tlEC_RedOvertime("RedOvertime")
	redcomponent.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, redovertime, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.red_component = redcomponent
	Local greencomponent:tlEC_GreenOvertime = New tlEC_GreenOvertime("GreenOvertime")
	greencomponent.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, greenovertime, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.green_component = greencomponent
	Local bluecomponent:tlEC_BlueOvertime = New tlEC_BlueOvertime("BlueOvertime")
	bluecomponent.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, blueovertime, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.blue_component = bluecomponent
	Local directioncomponent:tlEC_DirectionOvertime = New tlEC_DirectionOvertime("DirectionOvertime")
	directioncomponent.InitGraph(tlDIRECTION_OVERTIME_MIN, tlDIRECTION_OVERTIME_MIN, direction, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.direction_component = directioncomponent
	Local dvotcomponent:tlEC_DirectionVariationOvertime = New tlEC_DirectionVariationOvertime("DirectionVariationOvertime")
	dvotcomponent.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, directionvariationot, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.dvovertime_component = dvotcomponent
	Local spincomponent:tlEC_SpinOvertime = New tlEC_SpinOvertime("SpinOvertime")
	spincomponent.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, spinovertime, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.spin_component = spincomponent
	Local weightcomponent:tlEC_WeightOvertime = New tlEC_WeightOvertime("WeightOvertime")
	weightcomponent.InitGraph(tlGLOBAL_PERCENT_MIN, tlGLOBAL_PERCENT_MAX, weightovertime, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.weight_component = weightcomponent
	Local frameratecomponent:tlEC_FramerateOvertime = New tlEC_FramerateOvertime("FramerateOvertime")
	frameratecomponent.InitGraph(tlFRAMERATE_MIN, tlFRAMERATE_MAX, framerateovertime, tlOVERTIME_GRAPH, p.ParentEffect, p)
	p.framerate_component = frameratecomponent
	Return p
End Function
