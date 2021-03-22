# libasm
libasm is a project to rewrite following functions in assembly language.

| name | content |
| -- | -- |
| [ft_strlen](./srcs/ft_strlen.s) | man 3 strlen |
| [ft_strcpy](./srcs/ft_strcpy.s) | man 3 strcpy |
| [ft_strcmp](./srcs/ft_strcmp.s) | man 3 strcmp |
| [ft_write](./srcs/ft_write.s) | man 2 write |
| [ft_read](./srcs/ft_read.s) | man 2 read |
| [ft_strdup](./srcs/ft_strdup.s) | man 3 strdup |
| [ft_atoi_base](./bonus/ft_atoi_base_bonus.s) | like the one in the piscine |
| [ft_list_push_front](./bonus/ft_push_front_bonus.s) | like the one in the piscine |
| [ft_list_size](./bonus/ft_list_size_bonus.s) | like the one in the piscine |
| [ft_list_sort](./bonus/ft_list_sort_bonus.s) | like the one in the piscine |
| [ft_list_remove_if](./bonus/ft_list_remove_if_bonus.s) | like the one in the piscine |

## Getting Started
```Bash
git clone https://github.com/kefujiwa/libasm.git
cd libasm

# create library `libasm.a`
make all
make bonus

# test
make test
make testb (for bonus)
```

This will produce a `libasm.a` library which you can link to your project.
