# Nom de l'exécutable
NAME = push_swap

# Sources
SRCS =  ./src/error/verif.c \
		./src/utils/utils.c ./src/utils/utils_lst.c ./src/utils/algo.c ./src/utils/mouv.c\
		./src/main/pushswap.c \
		./src/mouv/push.c ./src/mouv/rotate.c ./src/mouv/swap.c ./src/mouv/reverse_rotate.c \
		
# Répertoire et archive de la libmy
LIBMY_DIR = ./include/libmy
LIBMY = $(LIBMY_DIR)/libmy.a

# Répertoires
BUILD_DIR = build

# Fichiers objets
OBJS = $(SRCS:%.c=$(BUILD_DIR)/%.o)

# Compilateur et options
CC = cc
CFLAGS = -Werror -Wextra -Wall -g

# Couleurs pour affichage
YELLOW = \033[0;33m
GREEN = \033[0;32m
RESET = \033[0m
RED = \033[0;31m

# Règle par défaut
all: $(LIBMY) $(NAME)

# Compilation de l'exécutable
$(NAME): $(OBJS)
	@echo "$(YELLOW)🔨 Linking $(NAME)... 🚀$(RESET)"
	$(CC) $(OBJS) $(LIBMY) $(LDFLAGS) -o $(NAME)
	@echo "$(GREEN)✅ Compilation successful!$(RESET)"

# Compilation de la libmy
$(LIBMY):
	@echo "$(YELLOW)🔨 Compiling libmy... 🚀$(RESET)"
	$(MAKE) -C $(LIBMY_DIR)

# Règle pour les fichiers objets, en créant les dossiers nécessaires
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	@echo "$(YELLOW)📝 Compiling $<...$(RESET)"
	$(CC) $(CFLAGS) -I$(LIBMY_DIR) -c $< -o $@
	@echo "$(GREEN)✅ Compilation of $< finished$(RESET)"

# Nettoyage des fichiers objets
clean:
	@echo "$(RED)🧹 Cleaning object files...$(RESET)"
	rm -rf $(BUILD_DIR)
	@echo "$(RED)🧹 Cleaning libmy objects...$(RESET)"
	$(MAKE) clean -C $(LIBMY_DIR)

# Nettoyage complet
fclean: clean
	@echo "$(RED)🧼 Removing executable...$(RESET)"
	rm -f $(NAME)
	@echo "$(RED)🧼 Cleaning libmy archive...$(RESET)"
	$(MAKE) fclean -C $(LIBMY_DIR)

# Recompilation complète
re: fclean all

# Mode debug
debug: CFLAGS += -g -fsanitize=address
debug: re

# Déclaration des cibles phony
.PHONY: all clean fclean re debug