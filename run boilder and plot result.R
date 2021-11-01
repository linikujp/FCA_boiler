library(reticulate)
library(here)

# py_install(c("concepts", "pandas"), pip = T)
source_python("boiler.py")
boiler(here::here("anthrax_formal_concept.csv"), here::here("anthrax_"))


# investigate a few network plotting libraries in R

library(ggraph)
library(tidygraph)

nodes <- readr::read_csv("anthrax_concept.csv") %>% 
  filter(id > 0) %>% 
  mutate(name = stringr::str_wrap(concept_name, width = 15))

edges <- readr::read_csv("anthrax_concept_relationship.csv") %>% 
  dplyr::transmute(to = id_2, from = id_1) %>% 
  filter(to > 0, from > 0)

graph <- tbl_graph(nodes, edges, directed = T)

# plot using ggraph
plt <- ggraph(graph, layout = 'kk') + 
  geom_edge_fan(show.legend = FALSE) + 
  geom_node_point() + 
  geom_node_text(aes(label = name)) #+
  geom_node_label(aes(label = name)) #+
  # theme_graph(foreground = 'steelblue', fg_text_colour = 'white') #+
  # expand_limits(x = c(-3, 3), y = c(-3, 3))

  
# library(plotly)
# ggplotly(plt)

  
nodes <- readr::read_csv("vaccine_fca_concept.csv") %>% 
  filter(id > 0) %>% 
  mutate(name = stringr::str_wrap(concept_name, width = 15))

edges <- readr::read_csv("vaccine_fca_concept_relationship.csv") %>% 
  dplyr::transmute(to = id_2, from = id_1) %>% 
  filter(to > 0, from > 0)

graph <- tbl_graph(nodes, edges, directed = T)

# plot using ggraph
# plt <- 
  ggraph(graph, layout = 'kk') + 
  geom_edge_fan(show.legend = FALSE) + 
  geom_node_point() + 
  scale_y_continuous(expand = expansion(.2)) +
  scale_x_continuous(expand = expansion(.2)) 
  
  # geom_node_text(aes(label = name)) #+

ggplotly(plt)
  
library(networkD3)

# n <- edges %>% 
#   left_join(select(nodes, id, to_name = concept_name), by = c("to"="id")) %>% 
#   left_join(select(nodes, id, from_name = concept_name), by = c("from"="id")) %>% 
#   select(to = to_name, from = from_name) 


simpleNetwork(edges)



