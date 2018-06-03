# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: abutok <abutok@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/03/22 16:24:00 by abutok            #+#    #+#              #
#    Updated: 2018/03/22 20:16:18 by abutok           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = RT
PARSON = ./parson/libparson.a
#	C compiler and his default flags
GCC = gcc -Wall -Wextra
#-Werror
#	Libft linking
LINKLIBFT = -L ./libft -lft
LINKPARSON = -L ./parson -lparson

# Lib SDL
LIBSDLINCLUDE = -I ./frameworks/SDL2.framework/Versions/A/Headers \
				-I ./frameworks/SDL2_ttf.framework/Versions/A/Headers \
				-I ./frameworks/SDL2_image.framework/Versions/A/Headers \
				-F ./frameworks/
LIBSDLFRAMES = -F ./frameworks \
				-rpath ./frameworks \
				-framework SDL2 \
				-framework SDL2_ttf -framework SDL2_image \

#Lib Tiny Files Dialogs
TINYFD_INCLUDE = -I./lib_tinyFD

TINY_LIB		= -lft lib_tinyFD/libtfd.a

#	Libs linking
LINKLIB = -framework OpenGL -framework AppKit -framework OpenCl -O3 -OFast -lmlx $(LINKLIBFT) $(LINKPARSON) $(LIBSDLFRAMES) $(TINY_LIB)
#	Sources directories
SRCDIR = ./src/
COLORDIR = ./src/color/
FIGUREDIR = ./src/figure/
LIGHTDIR = ./src/light/
VECTORDIR = ./src/vector/
PARSEDIR = ./src/parse/
OPENCLDIR = ./src/openCL/
EFFECTSDIR = ./src/effects/
GUIDIR = ./src/gui/

#	Source files
SRCFILES = main.c do_rt.c space.c solve_cubic.c solve_quatric.c
COLORFILES = color.c
FIGUREFILES = fsphere.c fplane.c fcylinder.c fcone.c ftriangle.c figure.c ftor.c \
				fcube.c fquadrate.c fparaboloid.c felipsoid.c
LIGHTFILES = light.c
VECTORFILES = vector.c vector2.c rotate.c
PARSEFILES = pcam.c pcone.c pcylinder.c perror.c ft_hexatoi.c plight.c parse.c \
				pplane.c psphere.c ptriangle.c pelipsoid.c preflection.c pvector.c \
				ptor.c pparaboloid.c pcut_plane.c pquadrate.c pcube.c check_parse.c  peffects.c

GUIFILES =  sdl_errors.c sdl_init.c init_buttons.c ok_button.c\
			button_functions.c create_text.c list_obj1.c slider.c \
			utils1.c list_obj2.c light_list.c sphere_prop.c sdl_quit.c \
			inf_cyl_prop.c get_prop.c plane_prop.c cone_prop.c triangle_prop.c \
			cube_prop.c quadrate_prop.c elipsoid_prop.c parabaloid_prop.c tor_prop.c\
			input.c input2.c light_point_prop.c amb_light.c light_direct.c \
			default.c \
			
OPENCLFILES = opencl_init.c cl_copy_data.c cl_set_args.c cl_wrapper.c copy1.c \
				copy2.c
EFFECTSFILES = normal_disruption.c perlin_noise.c perlin_noise.c

#	Header folder
INCLUDE = ./includes $(LIBSDLINCLUDE) $(TINYFD_INCLUDE)
#	Binaries folder
BINDIR = ./obj/
#	Binaries list
BIN = $(addprefix $(BINDIR), $(SRCFILES:.c=.o)) \
		$(addprefix $(BINDIR), $(COLORFILES:.c=.o)) \
		$(addprefix $(BINDIR), $(FIGUREFILES:.c=.o)) \
		$(addprefix $(BINDIR), $(LIGHTFILES:.c=.o)) \
		$(addprefix $(BINDIR), $(VECTORFILES:.c=.o)) \
		$(addprefix $(BINDIR), $(PARSEFILES:.c=.o)) \
		$(addprefix $(BINDIR), $(OPENCLFILES:.c=.o)) \
		$(addprefix $(BINDIR), $(GUIFILES:.c=.o))
#	Libft
LIBFT = ./libft/libft.a
#	Libft header
LIBFTINCLUDE = ./libft/includes
#	Parson header
PARSONINCLUDE = ./parson

.NOTPARALLEL = all fclean clean re $(NAME)

all: $(LIBFT) $(PARSON) $(NAME)

$(NAME): $(BINDIR) $(BIN)
	@$(GCC) $(LINKLIB) -o $(NAME) $(BIN) -I $(LIBFTINCLUDE) -I $(INCLUDE) \
		-I $(PARSONINCLUDE)

$(BINDIR):
	@if [ ! -d "$(BINDIR)" ]; then mkdir $(BINDIR); fi


$(BINDIR)%.o: $(PARSEDIR)%.c
	@$(GCC) -c -I $(INCLUDE) -I $(LIBFTINCLUDE) -I $(PARSONINCLUDE) $< -o $@

$(BINDIR)%.o: $(SRCDIR)%.c
	@$(GCC) -c -I $(INCLUDE) -I $(LIBFTINCLUDE) -I $(PARSONINCLUDE) $< -o $@

$(BINDIR)%.o: $(COLORDIR)%.c
	@$(GCC) -c -I $(INCLUDE) -I $(LIBFTINCLUDE) -I $(PARSONINCLUDE) $< -o $@

$(BINDIR)%.o: $(FIGUREDIR)%.c
	@$(GCC) -c -I $(INCLUDE) -I $(LIBFTINCLUDE) -I $(PARSONINCLUDE) $< -o $@

$(BINDIR)%.o: $(LIGHTDIR)%.c
	@$(GCC) -c -I $(INCLUDE) -I $(LIBFTINCLUDE) -I $(PARSONINCLUDE) $< -o $@

$(BINDIR)%.o: $(VECTORDIR)%.c
	@$(GCC) -c -I $(INCLUDE) -I $(LIBFTINCLUDE) -I $(PARSONINCLUDE) $< -o $@

$(BINDIR)%.o: $(GUIDIR)%.c
	@$(GCC) -c -I $(INCLUDE) -I $(LIBFTINCLUDE) -I $(PARSONINCLUDE) $< -o $@

$(BINDIR)%.o: $(OPENCLDIR)%.c
	@$(GCC) -c -I $(INCLUDE) -I $(LIBFTINCLUDE) -I $(PARSONINCLUDE) $< -o $@

# $(BINDIR)%.o: $(EFFECTSDIR)%.c
# 	$(GCC) -c -I $(INCLUDE) -I $(LIBFTINCLUDE) -I $(PARSONINCLUDE) $< -o $@

clean:
	@make -C ./libft/ clean
	@make -C ./parson/ clean
	@if [ -d "$(BINDIR)" ]; then rm -rf $(BINDIR); fi
	@echo "\033[32;1mCleaned\033[0m"

fclean: clean
	@make -C ./libft/ fclean
	@make -C ./parson/ fclean
	@if [ -f "$(NAME)" ]; then rm -rf $(NAME); fi

re: fclean all

$(LIBFT):
	@echo "\033[33;1mCompilation of libft...\033[0m"
	@make -C ./libft/

$(PARSON):
	@echo "\033[33;1mCompilation of parson...\033[0m"
	@make -C ./parson/
