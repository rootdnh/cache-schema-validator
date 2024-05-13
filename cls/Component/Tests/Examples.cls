Class Component.Tests.Examples Extends %RegisteredObject
{

ClassMethod DefineSchema(request As %DynamicObject)
{
	Set schema = ##class(Component.Validator.Main).%New(request)
	Do schema.Define("nome").Required()
	Do schema.Define("nomeMae").String()
	Do schema.Define("nomePai").Required().String()
	
	Set output = schema.Validate()
	Write output.errors.%ToJSON()
}

ClassMethod SetObject() As %Status
{
	Set Obj = {}
	Set Obj.nome = "JOAO"
	Set Obj.nomeMae = 13
	Do ..DefineSchema(Obj)
	Quit $$$OK
}

}
