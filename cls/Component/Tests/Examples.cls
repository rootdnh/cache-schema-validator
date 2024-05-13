Class Component.Tests.Examples Extends %RegisteredObject
{

ClassMethod DefineSchema(request As %DynamicObject)
{
	Set schema = ##class(Component.Validator.Main).%New(request)
	Do schema.Define("nome").Required()
	Do schema.Define("nomeMae").Required()
	Do schema.Define("nomePai").Required()
	
	Set output = schema.Validate()
	Write output.errors.%ToJSON()
}

ClassMethod SetObject() As %Status
{
	Set Obj = {}
	Set Obj.nome = "JOAO"
	Do ..DefineSchema(Obj)
	Quit $$$OK
}

Method MyMethod()
{
    Write "Current method name: ", %METHOD, !
}

}
