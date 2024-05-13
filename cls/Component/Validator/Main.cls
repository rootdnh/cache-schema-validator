Class Component.Validator.Main Extends %RegisteredObject
{

Property Request As %DynamicObject [ Internal ];

Property Key [ Internal ];

Property Value [ Internal ];

Property Err As %DynamicObject [ Internal ];

Method Init(key) As Component.Validator.Main
{
	Set ..Key = key
	Set ..Value = ..Request.%Get(key)
	Return $This
}

Method Required() As Component.Validator.Main
{
	If (..Value="") {
		Do ..Err.%Set("temErro",$$$YES,"boolean")
		Set erros = ..Err.erros
		Do:('erros.%IsDefined(..Key)) erros.%Set(..Key,[])
		Do erros.%Get(..Key).%Push("Required")
	}
	Return $This
}

Method String() As Component.Validator.Main
{
	If (..Value="") {
		Do ..Err.%Set("temErro",$$$YES,"boolean")
		Set erros = ..Err.erros
		Do:('erros.%IsDefined(..Key)) erros.%Set(..Key,[])
		Do erros.%Get(..Key).%Push("Required")
	}
	Return $This
}

Method Validate() As %DynamicObject
{
	Return ..Err
}

Method %OnNew(request As %DynamicObject) As %Status [ Private, ServerOnly = 1 ]
{
	Set ..Request = request
	
	Set ..Err = {
		"temErro": false,
		"erros": {}
	}
	Return $$$OK
}

}

