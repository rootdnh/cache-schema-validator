Class Component.Tests.Examples Extends %RegisteredObject
{

/// D ##class(User.App).Test()
ClassMethod Test(request = {{"nome":"JOAO", "nomeMae":""}})
{
	Set builder = ##class(Component.Validator.Main).%New(request)
	
	Do builder.Init("nome").Required()
	Do builder.Init("nomeMae").Required()
	Do builder.Init("nomePai").Required()
	
	Set output = builder.Validate()
	W output.erros.%ToJSON()
}

}

