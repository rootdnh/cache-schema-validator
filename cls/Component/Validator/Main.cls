Class Component.Validator.Main Extends %RegisteredObject
{

Property Request As %DynamicObject [ Internal ];

Property Key [ Internal ];

Property Value [ Internal ];

Property Err As %DynamicObject [ Internal ];

Method Define(key) As Component.Validator.Main
{
	Set ..Key = key, ..Value = ..Request.%Get(key)
	Return $This
}

Method RecordError(ErrorType As %String) As %Status
{
	Do ..Err.%Set("hasError", $$$YES, "boolean")
	Do:('..Err.errors.%IsDefined(..Key)) ..Err.errors.%Set(..Key, [])
	Do ..Err.errors.%Get(..Key).%Push(ErrorType)
}

Method Required() As Component.Validator.Main
{
	Do:(..Value="") ..RecordError("Required")
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
		"hasError": false,
		"errors": {}
	}
	Return $$$OK
}

}

