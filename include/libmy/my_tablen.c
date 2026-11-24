#include "libmy.h"

int	tablen(void **tab)
{
	int	i;

	i = 0;
	while (tab[i])
		i++;
	return (i);
}
