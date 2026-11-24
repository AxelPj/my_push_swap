#include "../../include/header/pushswap.h"

void	sa(t_list **stack_a, int bool)
{
	int	temp;

	temp = (*stack_a)->next->content;
	(*stack_a)->next->content = (*stack_a)->content;
	(*stack_a)->content = temp;
	if (bool == 0)
		write (1, "sa\n", 3);
}

void	sb(t_list **stack_b, int bool)
{
	int	temp;

	temp = (*stack_b)->next->content;
	(*stack_b)->next->content = (*stack_b)->content;
	(*stack_b)->content = temp;
	if (bool == 0)
		write (1, "sb\n", 3);
}

void	ss(t_list *stack_b, t_list *stack_a)
{
	sa(&stack_a, 1);
	sb(&stack_b, 1);
	write (1, "ss\n", 3);
}
