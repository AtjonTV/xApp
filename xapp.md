# xApp Project Generation Language v2.1

Created by: Thomas Obernosterer  
Created for: ATVG-Studios  
License: [OSPL20](https://atvg-studios.com/ospl/ospl20) (MPL Like)

## Set Generator (REQUIRED)

Command:
```
set_generator <name> <flags>
```

Example:

```
set_generator buffalo --flag=no-git
```

#### Available Generators

| Name | Since |
|------|-------|
| Buffalo | 1.0 |
| Rails | 2.0 |

## Set Flags (REQUIRES rel_flags TO BE CALLED AFTER)

Command:
```
set_flag <flag>
```

Example:

```
set_flag no-git
```

#### Available Flags (Generator dependent)

| Name | Generator | Since |
|------|-----------|-------|
| no-git | Buffalo/Rails | 1.1/2.0 |
| no-templates | Buffalo | 1.2 |
| no-migrations | Buffalo | 1.2 |
| no-coffee | Rails | 2.0 |
| no-js | Rails | 2.0 |


## Update Flags

Command:
```
rel_flags
```


## Generate new Project

Command:
```
# Buffalo
gen_project <name> <type> <ci type> <db type>

# Rails
gen_project <name> <type> <db type>
```

Example:

```
gen_project cookies api gitlab-ci mysql
```

*Note 1*: Rails does not support CI-Providers  
*Note 2*: Available Databases depend on used generator

#### Available Types

| Name | Generator | Since |
|------|-----------|-------|
| api  | Buffalo/Rails | 1.0/2.0 |
| app  | Buffalo/Rails | 1.0/2.0 |


## Generate new Resource

Command:
```
gen_resource <name> <flags>
```

Example:

```
gen_resource cookies name:string type_id:int
```


## Generate new Model

Command:
```
gen_model <name> <flags>
```

Example:

```
gen_model type topping_id:id
```


## Generate new Mailer

Command:
```
gen_mailer <name>
```

Example:

```
gen_mailer newsletter
```


## Generate new Action

Command:
```
gen_action <name>
```

Example:

```
gen_action bake
```


## Generate new Task

Command:
```
gen_task <name>
```

Example:

```
gen_task sync
```


## Generate new Migration

Command:
```
gen_migration <name> <generator params>
```

Example:

```
gen_migration AddTeamReferenceToUsers team_id:int
```

*Note 1*: Available Params to pass to Generator depend on Generator  
*Note 2*: Depending on the Generator, the output will differ


## Delete Project if exists

Command:
```
del_project <name>
```

Example:

```
del_project cookies
```


## End Generator (REQUIRED)

Command:
```
end_generator
```
