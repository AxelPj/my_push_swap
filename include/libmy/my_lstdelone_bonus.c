#include "libmy.h"

void	my_lstdelone(t_list *lst, void (*del)(int))
{
	del(lst->content);
	free(lst);
}
