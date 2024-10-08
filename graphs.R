

library(plotly)
library(dplyr)
create_plot_stages()


create_plot_stages <- function(){

stage <- c("1<br>Event",
           "2<br>Collect",
           "3<br>Classify",
           "4<br>Data",
           "5<br>Analyse",
           "6<br>Communicate",
           "7<br>Act")

hoverinfo <- c(
  "Stage 1: Infectious disease \nEvents ",
  "Stage 2: Collection of \nevents",
  "Stage 3: Classification \nof collected information",
  "Stage 4: Data management \nand processing",
  "Stage 5: Analysis and \nassessment of data",
  "Stage 6: Communication of\n findings",
  "Stage 7: Action based on \nsurveillance information"
)

size <- rep(1, 7)
colors <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
graphdata <- tibble(stage, hoverinfo, size)



# Create plot
plot_stages <- graphdata |>
  plot_ly(labels = ~stage,
          values = ~size,
          text = ~stage,
          pull = 0.02,
          marker = list(
            colors = colors,
            line = list(color = "#2C3E50", width = 2)  # Add white border around slices
          ),
          hoverinfo = 'text',
          textinfo = 'label',              # Show labels inside pie
          textfont = list(
            family = 'Arial, sans-serif',
            size = 20,
            color = "#2C3E50"  # Darker color for contrast
          ),
          insidetextorientation = 'horizontal',  # Ensure the text is easier to read
          # textposition = 'outside',
          hovertext = hoverinfo,
          hoverlabel = list(font = list(size = 20),  # Increase hover text size
                            namelength = -1,
                            padding = list(l = 30, r = 30, t = 30, b = 30))) |>
  add_pie(hole = 0.6, direction = "clockwise", rotation = -25) |>
  layout(showlegend = F,
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE) )  |>
  layout(
    margin = list(l = 50, r = 50, t = 50, b = 50),
    annotations = list(
      list(
        text = "Stages of \nSurveillance",  # Adjust text to describe the pie chart
        x = 0.5,
        y = 0.5,
        font = list(size = 28),
        showarrow = FALSE
      ))
    )

}



#
#
#
# # Load package
# # devtools::install_github("mattflor/chorddiag")
# library(chorddiag)
#
# # Create dummy data
# m <- matrix(
#   c(
#     0, 0, 0, 0, 100,
#     0, 0, 0, 0, 100,
#     0, 0, 0, 0, 100,
#     0, 0, 0, 0, 100,
#     0, 0, 0, 0, 100
#   ),
#   byrow = TRUE,
#   nrow = 5, ncol = 5
# )
#
# # A vector of 4 colors for 4 groups
# haircolors <- c("black", "blonde", "brown", "red", "green")
# dimnames(m) <- list(
#   have = haircolors,
#   prefer = haircolors
# )
# groupColors <- c("#000000", "#FFDD89", "#957244", "#F26223", "#215344")
#
# # Build the chord diagram:
# p <- chorddiag(m, groupColors = groupColors, groupnamePadding = 20)
# p
















# save the widget
# library(htmlwidgets)
# saveWidget(p, file=paste0( getwd(), "/HtmlWidget/chord_interactive.html"))














# sysfonts::font_add_google("Zilla Slab", "pf", regular.wt = 500)
#
#
#
#
# library(DiagrammeR)
#
# a_graph <-  create_graph() %>%
#   add_node(label = "Infektionsereignis (1)") %>%
#   add_node(labe = "Erfassung (2)") %>%
#   add_node(label = "Klassifikation (3)") %>%
#   add_node(label = "Datenverarbeitung (4)") %>%
#   add_node(label = "Bewertung (5)") %>%
#   add_node(label = "Kommunikation (6)") %>%
#   add_node(label = "Entscheidung (7)", type = "rect") %>%
#   add_edge(from = 1, to = 2) |>
#   add_edge(from = 2, to = 3) |>
#   add_edge(from = 3, to = 4) |>
#   add_edge(from = 4, to = 5) |>
#   add_edge(from = 5, to = 6) |>
#   add_edge(from = 6, to = 7) |>
#   add_edge(from = 7, to = 1) |>
#   set_node_attrs(node_attr = "shape", value = "rectangle") |>
#   set_node_attrs(node_attr = "style", value = "rounded,filled") %>%
#   set_node_attrs(node_attr = "color", value = "lightblue") |>
#   set_node_attrs(node_attr = "width", value = 1.4)
#
# render_graph(a_graph, layout = "circle")
#
# a_graph <-  create_graph() %>%
#   add_node(labe = "Events") %>%
#   add_node(label = "Classification") %>%
#   add_node(label = "Assessment") %>%
#   add_node(label = "Decision") %>%
#   add_edge(from = 1, to = 2) |>
#   add_edge(from = 2, to = 3) |>
#   add_edge(from = 3, to = 4) |>
#   add_edge(from = 4, to = 1)
#
#
# render_graph(a_graph, layout = "nicely")
#
#
# Surveillance systems
#
#
#
# ## Detailed graph about an infectious disease surveillance system
# library(DiagrammeR)
#
#
# a_graph <-  create_graph() %>%
#   add_node(labe = "Events") %>%
#   add_node(labe = "Info gathering") %>%
#   add_node(label = "Classification") %>%
#   add_node(label = "Data handling") %>%
#   add_node(label = "Quality check") %>%
#   add_node(label = "Signal detection") %>%
#   add_node(label = "Assessment") %>%
#   add_node(label = "Communication") %>%
#   add_node(label = "Measures") %>%
#   add_edge(from = 1, to = 2) |>
#   add_edge(from = 2, to = 3) |>
#   add_edge(from = 3, to = 4) |>
#   add_edge(from = 4, to = 1)
#
#
# render_graph(a_graph, layout = "nicely")
#
#
# DiagrammeR::grViz("digraph {
#
# graph [layout = dot, rankdir = LR]
#
# # define the global styles of the nodes. We can override these in box if we wish
# node [shape = rectangle, style = filled, fillcolor = Linen]
#
# data1 [label = 'Event', shape = folder, fillcolor = Beige]
# data2 [label = 'Event', shape = folder, fillcolor = Beige]
# process [label =  'Collection \n Classification']
# data [label =  'Data', shape = cylinder]
# statistical [label = 'Information', shape = signature]
#
# # edge definitions with the node IDs
# {data1 data2}  -> process -> data -> statistical
# }")
#
#
#
# library(rsvg)
#
#
# plot_info_for_action <- DiagrammeR::grViz("digraph {
# graph [layout = dot, rankdir = LR]
# # define the global styles of the nodes. We can override these in box if we wish
# node [shape = rectangle, style = filled, fillcolor = Linen]
# information [label =  'Information']
# action [label =  'Action']
#
# # edge definitions with the node IDs
# information -> action
# }")
#
#
# # Save the grViz plot as an SVG file
# svg_file <- tempfile(fileext = ".svg")
# DiagrammeR::export_svg(plot_info_for_action) %>% charToRaw() %>% rsvg::rsvg_svg(svg_file)
#
# # Convert the SVG file to a PNG file
# png_file <- tempfile(fileext = ".png")
# rsvg::rsvg_png(svg_file, png_file)
#
#
#
#
#
# plot(sticker(a_graph,
#              package="Infectious disease",
#              h_fill="#07A1E2", h_color="#185191",
#              url="produnis.de/R", u_size=5, u_color="white",
#              p_size=15,
#              s_x=1, s_y=.75, s_width=.6,
#              filename="imgfile.png"))
#
#
#
#
# library(hexSticker)
# imgurl <- system.file("img/surveillance.png", package="hexSticker")
# plot(sticker("img/surveillance.png",
#              package="Infectious disease",
#              h_fill="#07A1E2", h_color="#185191",
#              url="produnis.de/R", u_size=5, u_color="white",
#              p_size=15,
#              s_x=1, s_y=.75, s_width=.6,
#         filename="imgfile.png"))
#
#
#
#
# plot(hexSticker::sticker(ggplot2::ggplot() +
#                            ggplot2::theme_void() +
#                            ggplot2::annotate("text", x=1, y=1, label= "Information", label= "bolditalic(hello)",
#                                              col="blue", size=10) +
#                            ggplot2::annotate("text", x=1, y=2, label= "Action"),
#              package="Infectious disease Surveillance", p_size=8, p_x = 1, s_x=0.8, s_y=.6, s_width=1.4, s_height=1.2,
#              url = "www.test",
#              filename="baseplot.png")
#
# )
#
#
#
#
#
#
#
#
#
#
#
# library(DiagrammeR)
# library(hexSticker)
# library(DiagrammeRsvg)
# library(rsvg)
#
# # Create a simple diagram
# graph <- grViz("
#   digraph {
#     graph [layout = dot, rankdir = TB]
#     node [shape = rectangle, style = filled, color = lightblue]
#
#     A [label = 'Info']
#     C [label = 'Action']
#
#     A -> C
#   }
# ")
#
#
# ggplot()
#
# # Save the diagram as an SVG file first
# graph_svg <- export_svg(graph)
#
# # Convert SVG to PNG
# rsvg_png(charToRaw(graph_svg), "diagram.png", width = 50, height = 50)
#
#
# # Create the hex sticker with the diagram
# s <- sticker("diagram.png",
#         package = "MyPackage", # Name of your package or text
#         p_size = 3,
#         s_x = 1, s_y = 0.8, s_width = 0.8, # Position and size of the image
#         h_fill = "#FFFFFF", # Hex color for background
#         h_color = "#000000", # Hex color for border
#         filename = "hexSticker.png")
#
# plot(s)
#
#
#
#
#
#
#
