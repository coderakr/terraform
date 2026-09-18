# Terraform function
A Terraform function takes one or more inputs and returns a value.

***
## String Functions
### upper
- Converts a string to uppercase.
```hcl
locals {
  environment = "dev"

  environment_upper = upper(local.environment)
}
```
### lower
- Converts a string to lowercase.
```hcl
locals {    
    environment = "DEV"
    environment_lower = lower(local.environment)
    }
```

### title
- Converts a string to title case.
```hcl
locals {
    message = "hello terraform"
    message_title = title(local.message)
}
```
Result
```hcl
    message_title = "Hello Terraform"
```

### trimspace
- Removes all leading and trailing whitespace from a string.
```hcl
locals {
    message = "   hello terraform   "
    message_trimspace = trimspace(local.message)
}
```
Result
```hcl
    message_trimspace = "hello terraform"
```

### replace
- Replaces all occurrences of a substring within a string with another substring.
```hcl
locals {
    message = "hello terraform"
    message_replace = replace(local.message, "terraform", "world")
}
```
Result
```hcl
    message_replace = "hello world"
```
### format
- Builds a string using placeholders.
```hcl
format("%s-%s", "dev", "api")
```
result
```hcl
    "dev-api"
```
***
## join() and split()
### join()
- Combines a list of strings.
```hcl
locals {
    list_of_strings = ["dev", "api", "v1"]
    joined_string = join("-", local.list_of_strings)
}
```
Result
```hcl
    joined_string = "dev-api-v1"
```
### split()
- Splits a string into a list of substrings based on a delimiter.
```hcl
locals {
    string_to_split = "dev-api-v1"
    split_list = split("-", local.string_to_split)
}
```
Result
```hcl
    split_list = ["dev", "api", "v1"]
```
***
## Collection Functions
Terraform has functions for lists, sets, and maps.

### length
- Returns the number of elements in a collection.
```hcl
locals {
    my_list = ["dev", "api", "v1"]
    list_length = length(local.my_list)
}
```
Result
```hcl
    list_length = 3
```
***
## concat
- Concatenates two or more lists into a single list.
```hcl
locals {
    list1 = ["dev", "api"]
    list2 = ["v1", "v2"]
    concatenated_list = concat(local.list1, local.list2)
}
```
Result
```hcl
    concatenated_list = ["dev", "api", "v1", "v2"]
``` 
***
## flatten
- Flattens a list of lists into a single list.
```hcl
locals {
    list_of_lists = [["dev", "api"], ["v1", "v2"]]
    flattened_list = flatten(local.list_of_lists)
}
```
Result
```hcl
    flattened_list = ["dev", "api", "v1", "v2"]
```
***
## Distinct
- Removes duplicate elements from a list.
```hcl
locals {
    my_list = ["dev", "api", "v1", "dev"]
    distinct_list = distinct(local.my_list)
}
```
Result
```hcl
    distinct_list = ["dev", "api", "v1"]    
```
***
## sort
- Sorts a list of strings in ascending order.
```hcl
locals {
    my_list = ["v1", "api", "dev"]
    sorted_list = sort(local.my_list)
}
```
Result
```hcl
    sorted_list = ["api", "dev", "v1"]
```
***
## reverse
- Reverses the order of elements in a list.
```hcl
locals {
    my_list = ["dev", "api", "v1"]
    reversed_list = reverse(local.my_list)
}
```
Result
```hcl
    reversed_list = ["v1", "api", "dev"]
```
***
## contains
- Checks if a list contains a specific element.
```hcl
locals {
    my_list = ["dev", "api", "v1"]  
    contains_element = contains(local.my_list, "api")
}
```
Result
```hcl
    contains_element = true
```
***
## lookup
- Retrieves a value from a map based on a given key.
```hcl
locals {
    my_map = {
        "dev" = "Development Environment"
        "api" = "API Service"
        "v1" = "Version 1"
    }
    lookup_value = lookup(local.my_map, "api", "Default Value")
}
```
Result
```hcl
    lookup_value = "API Service"
```
- Note: If the key does not exist in the map, the default value will be returned.
***
##  keys() and values()
### keys()
- Returns a list of keys from a map.
```hcl
locals {
    my_map = {
        "dev" = "Development Environment"
        "api" = "API Service"
        "v1" = "Version 1"
    }
    map_keys = keys(local.my_map)
}
```
Result
```hcl
    map_keys = ["dev", "api", "v1"]
```
### values()
- Returns a list of values from a map.
```hcl
locals {    
    my_map = {
        "dev" = "Development Environment"
        "api" = "API Service"
        "v1" = "Version 1"
    }
    map_values = values(local.my_map)
}
```
Result
```hcl
    map_values = ["Development Environment", "API Service", "Version 1"]
```
***
## merge
- Merges two or more maps into a single map.
```hcl
locals {
    map1 = {
        "dev" = "Development Environment"
        "api" = "API Service"
    }
    map2 = {
        "v1" = "Version 1"
        "v2" = "Version 2"
    }
    merged_map = merge(local.map1, local.map2)
}
```
Result
```hcl
    merged_map = {
        "dev" = "Development Environment"
        "api" = "API Service"
        "v1" = "Version 1"
        "v2" = "Version 2"
    }
```
***
## Numeric Functions
Terraform also has mathematical functions.

### max
- Returns the maximum value from a list of numbers.
```hcl
locals {    
    my_numbers = [10, 5, 20, 15]
    max_value = max(local.my_numbers...)
}
``` 
result
```hcl
    max_value = 20
```
### min
- Returns the minimum value from a list of numbers.
```hcl
locals {    
    my_numbers = [10, 5, 20, 15]
    min_value = min(local.my_numbers...)
}
```
result
```hcl
    min_value = 5
```
### abs
- Returns the absolute value of a number.
```hcl  
locals {    
    my_number = -10
    absolute_value = abs(local.my_number)
}
``` 
result
```hcl
    absolute_value = 10
```
### ceil
- Rounds a number up to the nearest integer.
```hcl
locals {    
    my_number = 3.2
    rounded_up = ceil(local.my_number)  
}
``` 
result
```hcl
    rounded_up = 4
```
### floor
- Rounds a number down to the nearest integer.
```hcl
locals {    
    my_number = 3.8
    rounded_down = floor(local.my_number)   
}
```
result
```hcl
    rounded_down = 3
```
***
## Conditional Functions
### coalesce 
- Returns the first non-null or non-empty value from a list of values.
```hcl
locals {    
    value1 = null
    value2 = "Hello"
    value3 = "World"
    first_non_null = coalesce(local.value1, local.value2, local.value3)
}
```
result
```hcl
    first_non_null = "Hello"
```
***
## try
- Evaluates a list of expressions and returns the first one that does not produce an error.
```hcl
locals {    
    value1 = 10
    value2 = 0
    value3 = 5

    result = try(local.value1 / local.value2, local.value3)
}
```
result
```hcl
    result = 5
```
***
## can
- Checks if an expression can be evaluated without producing an error.
```hcl
locals {    
    value1 = 10
    value2 = 0
    value3 = 5

    can_evaluate = can(local.value1 / local.value2)
}
```
result
```hcl
    can_evaluate = false    
```
***
## Type Conversion Functions
Terraform has functions for converting types.

### tostring
- Converts a value to a string.
```hcl
locals {    
    my_number = 10
    number_as_string = tostring(local.my_number)
}
```
result
```hcl
    number_as_string = "10"
```
### tonumber
``` hcl
tonumber("123")
```
result
```hcl
    123
```
### tobool
``` hcl
tobool("true")
``` 
result
```hcl
    true
```
### tolist
- Converts a value to a list.
``` hcl
tolist(["a", "b", "c"])
```
result
```hcl
    ["a", "b", "c"]
```
### toset
- Converts to a set.
``` hcl
toset(["a", "b", "c"])
```
result
```hcl
  {"a", "b", "c"}
```
***
## File Functions
### file()
- Reads the contents of a file and returns it as a string.
```hcl
locals {
    file_contents = file("example.txt")
}
```
### filebase64()
- Reads the contents of a file and returns it as a base64-encoded string.
```hcl
locals {
    file_base64 = filebase64("example.txt")
}
```
### templatefile()
- Reads a template file and renders it with the provided variables.
```hcl
locals {
    template_contents = templatefile("template.txt", {
        name = "John Doe"
        age  = 30
    })
}
```
***
## Path Functions
### path.module
- Directory containing the current Terraform module.
### path.root
- Root module directory.
### path.cwd
- Directory where Terraform was invoked.
***
## Encoding Functions
Terraform can work with JSON and Base64.
### jsonencode()
- Converts a value to a JSON string.
```hcl
locals {
    my_map = {
        "name" = "John Doe"
        "age"  = 30
    }
    json_string = jsonencode(local.my_map)
}
```
result
```hcl
jsonencode({
  name = "ayush"
  age  = 22
})
```
result
```json
{"name":"ayush","age":22}
```
### jsondecode()
- Converts a JSON string to a value.
```hcl
locals {    
    json_string = "{\"name\":\"John Doe\",\"age\":30}"
    decoded_value = jsondecode(local.json_string)
}
```
result
```hcl
decoded_value = {
  "name" = "John Doe"
  "age"  = 30
}
```
***
## Date/Time Functions
```hcl
output "current_time" {
  value = timestamp()
}
```
result
```hcl
current_time = "2024-06-15T12:34:56Z"
```
- Note: You also have
formatdate()
timeadd()
timecmp()

***
## Hash/Crypto Functions
- Terraform also supports functions such as:
```
md5()
sha1()
sha256()
base64sha256()
```
example
```hcl
sha256("hello")
```
- These are useful for things like generating deterministic hashes.

A particularly useful pattern is:
```hcl
filemd5("config.json")
```
- This can help detect file changes.
***
## 

