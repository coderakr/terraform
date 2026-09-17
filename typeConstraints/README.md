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
```hcl 
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
availability_zones = [
  "ap-south-1a",
  "ap-south-1b",
  "ap-south-1c"
]
```
### set
- `set(<TYPE>)` - An unordered collection of unique values of the same type.
example:
```hcl
variable "security_groups" {
  type = set(string)
}
```
Accepts:
```
security_groups = [
  "web-sg",
  "ssh-sg",
  "db-sg"
]
```
- Note: 
    list → ordered + duplicates allowed
    set  → unordered + duplicates removed

### Map
- `map(<TYPE>)` - A collection of key-value pairs where keys are strings and values are of the same type.
```hcl
variable "tags" {
  type = map(string)
}
```
Accepts:
```
tags = {
  Environment = "dev"
  Project     = "backend"
  Owner       = "ayush"
}
```
***
## 3. Structural types
### Object
- `object({ <ATTR_NAME> = <TYPE>, ... })` - A collection of named attributes, each with a specific type.
example:
```hcl
variable "server" {
  type = object({
    name   = string
    cpu    = number
    enabled = bool
  })
}
```
Accepts:
```
server = {
  name    = "web-server"
  cpu     = 4
  enabled = true
}
```
- Note: This is useful when you want a variable to have a specific schema.

### tuple
- `tuple([<TYPE>, ...])` - An ordered sequence of values of potentially different types.
example:
```hcl
variable "server_info" {
  type = tuple([
    string,
    number,
    bool
  ])
}
```
Accepts:
```
server_info = [
  "web-server",
  2,
  true
]
```
- Note: The positions matter:
```
index 0 → string
index 1 → number
index 2 → bool
```
****
## 4. Nested types
``` hcl
variable "servers" {
  type = list(object({
    name = string
    cpu  = number
    tags = map(string)
  }))
}
```
Accepts:
```
servers = [
  {
    name = "web"
    cpu  = 2

    tags = {
      Environment = "dev"
    }
  },
  {
    name = "api"
    cpu  = 4

    tags = {
      Environment = "dev"
    }
  }
]
```
- Note: This is very common in real Terraform modules.
***
### 5. any
- `any` - A special type that allows any value, regardless of its type.
``` hcl
variable "config" {
  type = any
}
```
Accepts:
```
config = {
  name = "web-server"
  cpu  = 2
}
config = [
  "web-server",
  2,    
]
config = "some string"
config = 42
```
- Note: However, don't use any by default. For production modules, explicit types are generally preferable because they catch configuration errors early.

# Cheat sheet
| Type            | Example                        |
| --------------- | ------------------------------ |
| `string`        | `"dev"`                        |
| `number`        | `10`                           |
| `bool`          | `true`                         |
| `list(string)`  | `["a", "b"]`                   |
| `set(string)`   | `["a", "b"]`                   |
| `map(string)`   | `{env = "dev"}`                |
| `object({...})` | `{name = "web", cpu = 2}`      |
| `tuple([...])`  | `["web", 2, true]`             |
| `any`           | Any compatible Terraform value |
