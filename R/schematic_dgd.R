usethis::use_data_table()

#' Schematic DGP
#' TODO: think about how to specify these, where they should live in the tlverse
#' @rdname schematic
#' @export
schematic_g <- function(W){
  pA <- plogis(-0.1 * W)
  return(pA)
}

#' @rdname schematic
#' @export
schematic_Q <- function(A,W){
  EY = 0.2*(-10 * A + W - 0.2*W^2 + 0.4*A*W^2)
  return(EY)
}

#' @rdname schematic
#' @export
gen_schematic <- function(n, eps_sd = 0.2){
  W <- sample(1:10,n,replace=TRUE)
  pA <- schematic_g(W)
  A <- rbinom(n,1,pA)
  EY <- schematic_Q(A,W)
  Y <- EY + 2*rnorm(n,0,eps_sd)
  data <- data.table(W,A,Y)
}

#' @rdname schematic
#' @export
make_schematic_grid <- function(){
  schematic_grid <- data.table(expand.grid(W=1:10, A=0:1))
  schematic_grid[,QW_0:=1/10]
  schematic_grid[,pA_0:=schematic_g(A)]
  schematic_grid[,EY_0:=schematic_Q(A,W)]
  schematic_grid[,Y:=EY_0]
  schematic_grid[,type:="P_0"]
  return(schematic_grid)
}

#' @rdname schematic
#' @export
plot_schematic <- function(schematic,
                           grid=NULL,
                           meta=NULL,
                           type="line"){
  # TODO: maybe omit rug and lines if these are null
  # TODO: have option for facet or line type for different estimators/truth
  if(missing(meta)){
    meta <- schematic_meta
  }


  point_alpha = 1

  # from:
  # viridis::viridis_pal()(4)[c(1,3,2,4)]
  cbPalette <- c("#440154FF", "#35B779FF", "#31688EFF", "#FDE725FF")

  # TODO: fix X + Y labels (something is weird)

  # basic plot
  plot_obj <- ggplot(schematic,aes(x=W,y=Y, color=factor(A)))+
    geom_point(alpha=point_alpha)+
    scale_color_manual("Treatment Level (A)",values=cbPalette)+
    scale_x_continuous(name = "Covariate (W)", limits = meta$lims$W)+
    scale_y_continuous(name = "Outcome (Y)", limits = meta$lims$Y)+
    theme_bw()

  # add likelihood estimation lines if providef
  if(!missing(grid)){
    type_guide <- ifelse(length(unique(grid$type))>1,"legend","none")

    plot_obj <- plot_obj +
      geom_line(data=grid,aes(linetype=type))+theme_bw()+
      scale_linetype_discrete("Estimation", guide = type_guide)
  }

  if(!missing(meta)){
    plot_obj <- plot_obj +
      geom_rug(data=meta$tsm_0,aes(x=NULL, linetype=type), sides="r")
  }

  if(type=="facet"){
    plot_obj <- plot_obj + facet_wrap(~type)
  }

  return(plot_obj)
}
