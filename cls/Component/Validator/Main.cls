Class Component.Validator.Main Extends %RegisteredObject
{

Property Request As %DynamicObject [ Internal ];

Property Key [ Internal ];

Property Value [ Internal ];

Property Err As %DynamicObject [ Internal ];

Property ValidKeys As %DynamicObject [ Internal ];

Method InitValidKeys() As %Status
{
	Set ..ValidKeys.string = "string"
	Set ..ValidKeys.required = "required"
	Set ..ValidKeys.number = "number"
	Set ..ValidKeys.object = "object"
	Set ..ValidKeys.array = "array"
	Quit $$$OK
}

Method Define(key) As Component.Validator.Main
{
	Set ..Key = key, ..Value = ..Request.%Get(key)
	Return $This
}

Method RecordError(ErrorType As %String) As %Status
{
	Do ..Err.%Set("hasError", $$$YES, "boolean")
	Do:('..Err.keyTypeError.%IsDefined(..Key)) ..Err.keyTypeError.%Set(..Key, [])
	Do ..Err.keyTypeError.%Get(..Key).%Push(ErrorType)
}

Method Required() As Component.Validator.Main
{
	Do:(..Value="") ..RecordError(..ValidKeys.required)
	Return $This
}

Method String() As Component.Validator.Main
{
	Do:(..Request.%GetTypeOf(..Key)'=..ValidKeys.string) ..RecordError(..ValidKeys.string)
	Return $This
}

Method Number() As Component.Validator.Main
{
	Do:(..Request.%GetTypeOf(..Key) '= ..ValidKeys.number) ..RecordError(..ValidKeys.number)
	Return $This
}

Method Object() As Component.Validator.Main
{
	Do:(..Request.%GetTypeOf(..Key) '= ..ValidKeys.object) ..RecordError(..ValidKeys.object)
	Return $This
}

Method Array() As Component.Validator.Main
{
	Do:(..Request.%GetTypeOf(..Key) '= ..ValidKeys.array) ..RecordError(..ValidKeys.array)
	Return $This
}

Method Validate() As %DynamicObject
{
	Return ..Err
}

Method %OnNew(request As %DynamicObject) As %Status [ Private, ServerOnly = 1 ]
{
	Set ..Request = request
	Do ..InitValidKeys()
	Set ..Err = {
		"hasError": false,
		"keyTypeError": {}
	}
	Return $$$OK
}

}
