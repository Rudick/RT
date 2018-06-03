/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   inf_cyl_prop.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: arudenko <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/05/16 15:37:32 by arudenko          #+#    #+#             */
/*   Updated: 2018/05/16 15:37:34 by arudenko         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

static inline void	ic_prop2(t_view *s)
{
	s->ic.ic_rect[4] = make_rect(10, 400, 100, 32);
	s->ic.ic_tex[4] = create_text(s, "Reflection", 2, 32);
	s->ic.ic_pr_rect[4] = make_rect(120, 400, 60, 32);
	s->ic.ic_prop[4] =  tf(s, 0, 2, 32);
	s->ic.ic_rect[5] = make_rect(10, 450, 100, 32);
	s->ic.ic_tex[5] = create_text(s, "Vector-X", 2, 32);
	s->ic.ic_pr_rect[5] = make_rect(120, 450, 60, 32);
	s->ic.ic_prop[5] =  tf(s, 0, 2, 32);
	s->ic.ic_rect[6] = make_rect(10, 500, 100, 32);
	s->ic.ic_tex[6] = create_text(s, "Vector-Y", 2, 32);
	s->ic.ic_pr_rect[6] = make_rect(120, 500, 60, 32);
	s->ic.ic_prop[6] =  tf(s, 0, 2, 32);
	s->ic.ic_rect[7] = make_rect(10, 550, 100, 32);
	s->ic.ic_tex[7] = create_text(s, "Vector-Z", 2, 32);
	s->ic.ic_pr_rect[7] = make_rect(120, 550, 60, 32);
	s->ic.ic_prop[7] =  tf(s, 0, 2, 32);
}

void	ic_prop(t_view *s)
{
	s->ic.ic_tex = (SDL_Texture **)malloc(sizeof(SDL_Texture*) * NUM_IC_PR);
	s->ic.ic_rect = (SDL_Rect *)malloc(sizeof(SDL_Rect) * NUM_IC_PR);
	s->ic.ic_pr_rect = (SDL_Rect *)malloc(sizeof(SDL_Rect) * NUM_IC_PR);
	s->ic.ic_prop = (SDL_Texture **)malloc(sizeof(SDL_Texture*) * NUM_IC_PR);
	s->ic.ic_rect[0] = make_rect(10, 200, 100, 32);
	s->ic.ic_tex[0] = create_text(s, "Start-X", 2, 32);
	s->ic.ic_pr_rect[0] = make_rect(120, 200, 60, 32);
	s->ic.ic_prop[0] =  tf(s, 0, 2, 32);
	s->ic.ic_rect[1] = make_rect(10, 250, 100, 32);
	s->ic.ic_tex[1] = create_text(s, "Start-Y", 2, 32);
	s->ic.ic_pr_rect[1] = make_rect(120, 250, 60, 32);
	s->ic.ic_prop[1] =  tf(s, 0, 2, 32);
	s->ic.ic_rect[2] = make_rect(10, 300, 100, 32);
	s->ic.ic_tex[2] = create_text(s, "Start-Z", 2, 32);
	s->ic.ic_pr_rect[2] = make_rect(120, 300, 60, 32);
	s->ic.ic_prop[2] =  tf(s, 0, 2, 32);
	s->ic.ic_rect[3] = make_rect(10, 350, 100, 32);
	s->ic.ic_tex[3] = create_text(s, "Radius", 2, 32);
	s->ic.ic_pr_rect[3] = make_rect(120, 350, 60, 32);
	s->ic.ic_prop[3] =  tf(s, 0, 2, 32);
	ic_prop2(s);
}

void	init_ic_prop(t_view *s)
{
	t_col	c;

	c = col_parse(s->space->cl_figures[s->rr.fl.y].color);
	s->sl[0]->slider_rect.x = c.red;
	s->sl[0]->clr.red = s->sl[0]->slider_rect.x;
	s->sl[1]->slider_rect.x = c.green;
	s->sl[1]->clr.green = s->sl[1]->slider_rect.x;
	s->sl[2]->slider_rect.x = c.blue;
	s->sl[2]->clr.blue = s->sl[2]->slider_rect.x;
	s->ic.ic_prop[0] = tf(s, s->space->cl_figures[s->rr.fl.y].start.x, 2, 32);
	s->ic.ic_prop[1] = tf(s, s->space->cl_figures[s->rr.fl.y].start.y, 2, 32);
	s->ic.ic_prop[2] = tf(s, s->space->cl_figures[s->rr.fl.y].start.z, 2, 32);
	s->ic.ic_prop[3] = tf(s, s->space->cl_figures[s->rr.fl.y].radius, 2, 32);
	s->ic.ic_prop[4] = tf(s, s->space->cl_figures[s->rr.fl.y].reflection, 2, 32);
	s->ic.ic_prop[5] = tf(s, s->space->cl_figures[s->rr.fl.y].vector.x, 2, 32);
	s->ic.ic_prop[6] = tf(s, s->space->cl_figures[s->rr.fl.y].vector.y, 2, 32);
	s->ic.ic_prop[7] = tf(s, s->space->cl_figures[s->rr.fl.y].vector.z, 2, 32);
}

void	print_ic_prop(t_view *s)
{
	int i;

	i = -1;
	SDL_RenderClear(s->rr.rend[2]);
	while (++i < NUM_IC_PR && s->flag == 0)
	{
		SDL_RenderCopy(s->rr.rend[2], s->ic.ic_tex[i], NULL, &s->ic.ic_rect[i]);
		SDL_RenderCopy(s->rr.rend[2], s->ic.ic_prop[i], NULL, &s->ic.ic_pr_rect[i]);
		SDL_RenderCopy(s->rr.rend[2], s->ok->b_ok, NULL, &s->ok->ok_rect);
		display_colored_rect(s);
	}
	SDL_RenderPresent(s->rr.rend[2]);
}

void	clean_ic_prop(t_view *s)
{
	int	i;

	i = -1;
	while (++i < NUM_IC_PR)
	{
		if (s->ic.ic_tex[i])
		{
			SDL_DestroyTexture(s->ic.ic_tex[i]);
			s->ic.ic_tex[i] = NULL;
		}
		if (s->ic.ic_prop[i])
		{
			SDL_DestroyTexture(s->ic.ic_prop[i]);
			s->ic.ic_prop[i] = NULL;
		}
	}
}
