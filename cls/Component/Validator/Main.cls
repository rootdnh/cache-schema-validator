Class Component.Validator.Main Extends %RegisteredObject
{

Property Request As %DynamicObject [ Internal ];

Property Key [ Internal ];

Property Value [ Internal ];

Property Err As %DynamicObject [ Internal ];

Method Init(key) As User.Builder
{
	Set ..Key = key
	Set ..Value = ..Request.%Get(key)
	Return $This
}

Method Required() As User.Builder
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

/// This callback method is invoked by the <METHOD>%New</METHOD> method to 
/// provide notification that a new instance of an object is being created.
/// 
/// <P>If this method returns an error then the object will not be created.
/// <p>It is passed the arguments provided in the %New call.
/// When customizing this method, override the arguments with whatever variables and types you expect to receive from %New().
/// For example, if you're going to call %New, passing 2 arguments, %OnNew's signature could be:
/// <p>Method %OnNew(dob as %Date = "", name as %Name = "") as %Status
/// If instead of returning a %Status code this returns an oref and this oref is a subclass of the current
/// class then this oref will be the one returned to the caller of %New method.
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

