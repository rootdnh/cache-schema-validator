**Caché Schema Validator**

*Examples* 
```
  Set schema = ##class(Component.Validator.Main).%New(request)
	Do schema.Define("nome").Required()
	Do schema.Define("nomeMae").String()
	Do schema.Define("nomePai").Required().String()
	
	Set output = schema.Validate()
	Write output.errors.%ToJSON()
```
