# xApp (Go Buffalo) Generation Language v1.0

Created by: Thomas Obernosterer  
Created for: ATVG-Studios  
License: [OSPL20](https://atvg-studios.com/ospl/ospl20) (MPL Like)

## Set Generator

Command:
```
set_generator <name>
```

Example:

```
set_generator buffalo
```

## Generate new Project

Command:
```
gen_project <name> <type> <ci type> <db type>
```

Example:

```
gen_project cookies api gitlab-ci mysql
```


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


## Delete Project if exists

Command:
```
del_project <name>
```

Example:

```
del_project cookies
```


## End Generator

Command:
```
end_generator
```