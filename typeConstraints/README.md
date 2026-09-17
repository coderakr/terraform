# Terraform Type Constraints

This repository demonstrates the use of type constraints in Terraform.

***
## 1. Primitive types
### Number
- `number` - A numeric value, either integer or float.
example:
```hcl
variable "instance_count" {
  type    = number
  default = 2
}
```
Accepts:
```
1
2
5
```

### String
- `string` - A sequence of characters.
example:
```hcl
variable "environment" {
  type    = string
  default = "dev"
}
```
Accepts:
```
"dev"
"staging"
"prod"
```

### Boolean
- `bool` - A boolean value, either true or false.
example:
``` json
variable "enable_logging" {
  type    = bool
  default = true
}
```
Accepts:
```
true
false   
```

***
## 2. Collection types
### List
- `list(<TYPE>)` - An ordered sequence of values of the same type.
example:
```hcl
variable "availability_zones" {
  type = list(string)
}
```
Accepts:
```
["us-east-1a", "us-east-1b", "us-east-1c"]
```


