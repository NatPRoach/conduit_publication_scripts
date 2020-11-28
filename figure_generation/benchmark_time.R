

#################################
#################################
## Set-up
# List of packages
PackageList <- c("cowplot", "here", "ggplot2")

# Check and install missing packages
## https://stackoverflow.com/questions/4090169/elegant-way-to-check-for-missing-packages-and-install-them
install.packages.auto <- function(x) { 
  if (isTRUE(x %in% .packages(all.available = TRUE))) { 
    eval(parse(text = sprintf("require(\"%s\")", x)))
  } else { 
    #update.packages(ask= FALSE) #update installed packages.
    eval(parse(text = sprintf("install.packages(\"%s\", dependencies = TRUE)", x)))
  }
  if(isTRUE(x %in% .packages(all.available = TRUE))) { 
    eval(parse(text = sprintf("require(\"%s\")", x)))
  } else {
    if (!requireNamespace("BiocManager", quietly = TRUE))
      install.packages("BiocManager")
    eval(parse(text = sprintf("BiocManager::install(\"%s\")", x, update = FALSE)))
    eval(parse(text = sprintf("require(\"%s\")", x)))
  }
}

lapply(PackageList, function(x) {message(x); install.packages.auto(x)})
theme_set(theme_cowplot())

l4_df <- data.frame(tool=c(rep("RATTLE",2),rep("TALC",2),rep("Trinity",2),rep("CONDUIT",2),rep("rnaSPAdes",2)),
                    time_type=rep(c("preprocessing","runtime"),5),
                    time=c( 215, 31,     10, 112,      0, 322,     186,266,    0,211))

p1 <- ggplot(data=l4_df,
             aes(x=tool,
                 fill=factor(time_type,levels=c("runtime","preprocessing")),
                 y=time)) + 
  geom_bar(position="stack",stat="identity",color="#000000",width = 0.35) + 
  ylab("time (m)") +
  xlab("tool evaluated") +
  theme(legend.title = element_blank(),
        text = element_text(size = 12,family = "Helvetica"),
        axis.title.x = element_blank(),
        axis.text.x = element_text(size=12,family = "Helvetica"),
        axis.text.y = element_text(size=12,family = "Helvetica"),
        legend.text = element_text(size=12,family="Helvetica",margin=margin(r=8,l=4)))+
  scale_fill_manual(values=c("#8586A7","#789F5C","#D8B847","#B45D52"))

pdf(here("figures","figure3A.pdf"),width=7,height = 3,colormodel="rgb")
p1
dev.off()