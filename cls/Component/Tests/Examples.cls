Class Component.Tests.Examples Extends %RegisteredObject
{

ClassMethod DefineSchema(request As %DynamicObject)
{
	Set schema = ##class(Component.Validator.Main).%New(request)
	Do schema.Define("nome").Required()
	Do schema.Define("nomeMae").String()
	Do schema.Define("idade").Number().Required()
	Do schema.Define("object").Object().Required()
	Do schema.Define("array").Array().Required()
	
	Set output = schema.Validate()
	Write output.%ToJSON()
}

ClassMethod SetObject() As %Status
{
	Set Obj = {}
	Set Obj.nome = "JOAO"
	Set Obj.nomeMae = 13
	Set Obj.object = {"other": "think"}
	Set Obj.array = $$$NO
	Do ..DefineSchema(Obj)
	Quit $$$OK
}

}
