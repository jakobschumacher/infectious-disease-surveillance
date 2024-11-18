
pacman::p_load(dplyr, plotly, ggplot2)
create_surveillance_plot <- function(highlight = "none", output_type = "ggplot", language = "en") {

  # Data preparation with language selection
  if (language == "de") {
    stage <- c("1\nZiele",
               "2\nEreignis",
               "3\nSammeln",
               "4\nKlassifizieren",
               "5\nDaten",
               "6\nAnalysieren",
               "7\nKommunizieren",
               "8\nHandeln")

    hoverinfo <- c(
      "Stufe 1: Festlegung der Ziele",
      "Stufe 2: Definition der Ereignisse",
      "Stufe 3: Sammlung der Ereignisse",
      "Stufe 4: Klassifizierung der gesammelten Informationen",
      "Stufe 5: Datenmanagement und Verarbeitung",
      "Stufe 6: Analyse und Bewertung der Daten",
      "Stufe 7: Kommunikation der Ergebnisse",
      "Stufe 8: Maßnahmen basierend auf Überwachungsinformationen"
    )
    center_text <- "Schritte der\nSurveillance"
  } else {
    stage <- c("1\nObjectives",
               "2\nEvent",
               "3\nCollect",
               "4\nClassify",
               "5\nData",
               "6\nAnalyse",
               "7\nCommunicate",
               "8\nAct")

    hoverinfo <- c(
      "Stage 1: Set the objectives",
      "Stage 2: Define the Events",
      "Stage 3: Collect the events",
      "Stage 4: Classify collected information",
      "Stage 5: Data management and processing",
      "Stage 6: Analysis and assessment of data",
      "Stage 7: Communication of findings",
      "Stage 8: Action based on surveillance information"
    )
    center_text <- "Stages of\nSurveillance"
  }

  base_colors <- c('#1b9e77','#d95f02','#7570b3','#e7298a','#66a61e','#e6ab02','#a6761d','#666666')
  grey_color <- "#e3e3e3"

  # Create the color palette separately for each plot type
  if (output_type == "ggplot") {
    # Reverse color order for clockwise ggplot orientation
    colors <- if (highlight == "none") {
      rev(base_colors)
    } else {
      highlight_index <- as.integer(gsub("[^0-9]", "", highlight))
      rev(ifelse(1:8 == highlight_index, base_colors, grey_color))
    }
  } else {
    # Keep the original order for plotly
    colors <- if (highlight == "none") {
      base_colors
    } else {
      highlight_index <- as.integer(gsub("[^0-9]", "", highlight))
      ifelse(1:8 == highlight_index, base_colors, grey_color)
    }
  }

  # Create dataframe
  graphdata <- data.frame(stage = stage, hoverinfo = hoverinfo, size = rep(1, 8), colors = colors) |>
    dplyr::mutate(
      cumulative = cumsum(size),
      midpoint = cumulative - size / 2
    )

  if (output_type == "ggplot") {
    # ggplot version with larger hole and corrected clockwise orientation
    plot <- ggplot2::ggplot(dplyr::arrange(graphdata, dplyr::desc(stage)), ggplot2::aes(x = "", y = size, fill = stage)) +
      ggplot2::geom_col(width = 0.5, color = "white") +  # Set width to create larger hole
      ggplot2::geom_text(ggplot2::aes(y = midpoint, label = stage), color = "white", size = 4) +  # Labels inside slices
      ggplot2::coord_polar(theta = "y") +  # Reverse direction for clockwise
      ggplot2::scale_fill_manual(values = colors) +
      ggplot2::theme_void() +
      ggplot2::theme(
        legend.position = "none",
        plot.margin = ggplot2::margin(50, 50, 50, 50)
      ) +
      ggplot2::annotate("text", x = 0, y = 0, label = center_text, size = 6, hjust = 0.5)

    return(plot)

  } else if (output_type == "plotly") {
    # Plotly version with original color order
    plot <- plotly::plot_ly(
      data = graphdata,
      labels = ~stage,
      values = ~size,
      text = ~stage,
      pull = 0.02,
      marker = list(colors = colors),
      hoverinfo = 'text',
      textinfo = 'label',
      textfont = list(family = 'Arial, sans-serif', size = 12, color = "#fff"),
      insidetextorientation = 'horizontal',
      hovertext = hoverinfo,
      hoverlabel = list(font = list(size = 12), namelength = -1, padding = list(l = 30, r = 30, t = 30, b = 30))
    ) |>
      plotly::add_pie(hole = 0.6, direction = "clockwise", rotation = -25) |>
      plotly::layout(
        showlegend = FALSE,
        xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
        yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
        margin = list(l = 50, r = 50, t = 50, b = 50),
        annotations = list(
          list(
            text = center_text,
            x = 0.5,
            y = 0.5,
            font = list(size = 28),
            showarrow = FALSE
          )
        )
      )

    return(plot)
  } else {
    stop("Invalid output_type. Please use 'ggplot' or 'plotly'.")
  }
}


# Example usage
# create_surveillance_plot(highlight = "Stage 7", output_type = "ggplot", language = "de")
# create_surveillance_plot(highlight = "Stage 7", output_type = "plotly", language = "en")


