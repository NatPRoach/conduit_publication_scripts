
#################################
#################################
## Set-up
# List of packages
PackageList <- c("cowplot", "dplyr", "here", "ggplot2", "grid", "readxl")

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

# Change global default setting so every data frame created will not auto-convert to factors unless explicitly instructed
options(stringsAsFactors = FALSE)

#################################
#################################
## Data
# Read metasheet with benchmarking data
metasheet <- read_xlsx(here("figure_generation", "figure_data", "BenchmarkingMetasheet.xlsx"), sheet = 1)

filtering_metasheet <- read.csv(here("figure_generation", "figure_data", "Precision_v_read_count.csv"))

#################################
#################################
## Supplemental Figure 2: precision and recall of intron chains for all C elegans
IntronChainData <- metasheet %>% 
  filter(level == "intron chain", dataset %in% c("L1","L2","L3","L4","YA","GA", "Male")) %>%
  mutate(tool_stats = paste0(tool, "_", stats))

IntronChain_Plot <- ggplot(data = transform(IntronChainData,dataset = factor(dataset, levels = c("L1","L2","L3","L4","YA","GA", "Male"),labels=c("L1","L2","L3","L4","Young Adult","Gravid Adult", "Male"))), aes(x = tool, y = value, fill = tool)) +
  geom_bar(stat = "identity", position = position_dodge2(),color="#000000",aes( alpha = stats)) +
  geom_text(aes(label=sprintf("%0.1f", round(value,digits=1))),position=position_dodge2( width = 0.9 ),vjust= -0.25,size=2.0)+
  facet_wrap(~dataset,nrow = 2,ncol = 4) +
  theme(legend.title = element_blank(),
        legend.position = "bottom",
        legend.justification = "center",
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) + 
  labs(x = "", y = "precision and recall (%)", title = "") +
  scale_y_continuous(limits = c(0, 90), breaks = c(0, 20, 40, 60, 80)) +
  scale_fill_manual(values = c("#8586A7","mediumpurple","#547C9B","#B45D52", "orange","#789F5C","#D8B847")) +
  scale_alpha_discrete(range = c(1.0, 0.5))

pdf(file = here("figures", "SupplementalFigure2.pdf"), height = 8.5, width = 11)
plot(IntronChain_Plot)
dev.off()

## Figure 4A: precision and recall of intron chains for C. elegans L4 and males.
IntronChainData <- metasheet %>% 
  filter(level == "intron chain", dataset %in% c("L4","Male")) %>%
  mutate(tool_stats = paste0(tool, "_", stats))

IntronChain_Plot <- ggplot(data = transform(IntronChainData,dataset = factor(dataset, levels = c("L4","Male"),labels=c("L4", "Male"))), aes(x = tool, y = value, fill = tool)) +
  geom_bar(stat = "identity", position = position_dodge2(),color="#000000",aes( alpha = stats)) +
  geom_text(aes(label=sprintf("%0.1f", round(value,digits=1))),position=position_dodge2( width = 0.9 ),vjust= -0.25,size=2.0)+
  facet_wrap(~dataset) +
  theme(legend.title = element_blank(),
        # legend.position = "bottom",
        # legend.justification = "center",
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) + 
  labs(x = "", y = "precision and recall (%)", title = "") +
  scale_y_continuous(limits = c(0, 90), breaks = c(0, 20, 40, 60, 80)) +
  scale_fill_manual(values = c("#8586A7","mediumpurple","#547C9B","#B45D52", "orange","#789F5C","#D8B847")) +
  scale_alpha_discrete(range = c(1.0, 0.5))

pdf(file = here("figures", "Figure4A.pdf"), height = 4, width = 7.5)
plot(IntronChain_Plot)
dev.off()




#################################
#################################
## Suppleemental Figure 3: precision and recall of predicted protein products for all C. elegans
ProteinData <- metasheet %>% 
  filter(level == "protein", dataset %in% c("L1","L2","L3","L4","YA","GA", "Male")) %>%
  mutate(tool_stats = paste0(tool, "_", stats))

Protein_Plot <- ggplot(data = transform(ProteinData,dataset = factor(dataset, levels = c("L1","L2","L3","L4","YA","GA", "Male"),labels=c("L1","L2","L3","L4","Young Adult","Gravid Adult", "Male"))), aes(x = tool, y = value, fill = tool)) +
  geom_bar(stat = "identity", position = position_dodge2(),color="#000000",aes( alpha = stats)) + 
  geom_text(aes(label=sprintf("%0.1f", round(value,digits=1))),position=position_dodge2( width = 0.9 ),vjust= -0.25,size=2.0)+
  facet_wrap(~dataset,nrow = 2,ncol = 4) +
  theme(legend.title = element_blank(),
        legend.position = "bottom",
        legend.justification = "center",
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) + 
  labs(x = "", y = "precision and recall (%)", title = "") +
  scale_y_continuous(limits = c(0, 90), breaks = c(0, 20, 40, 60, 80)) +
  scale_fill_manual(values = c("#8586A7","mediumpurple","#547C9B","#B45D52", "orange","#789F5C","#D8B847")) +
  scale_alpha_discrete(range = c(1.0, 0.5))

pdf(file = here("figures", "SupplementalFigure3.pdf"), height = 8.5, width = 11)
plot(Protein_Plot)
dev.off()

#################################
#################################
## Figure 4B: precision and recall of predicted protein products for C. elegans L4 and males.
ProteinData <- metasheet %>% 
  filter(level == "protein", dataset %in% c("L4","Male")) %>%
  mutate(tool_stats = paste0(tool, "_", stats))

Protein_Plot <- ggplot(data = transform(ProteinData,dataset = factor(dataset, levels = c("L4", "Male"),labels=c("L4", "Male"))), aes(x = tool, y = value, fill = tool)) +
  geom_bar(stat = "identity", position = position_dodge2(),color="#000000",aes( alpha = stats)) + 
  geom_text(aes(label=sprintf("%0.1f", round(value,digits=1))),position=position_dodge2( width = 0.9 ),vjust= -0.25,size=2.0)+
  facet_wrap(~dataset) +
  theme(legend.title = element_blank(),
        # legend.position = "bottom",
        # legend.justification = "center",
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) + 
  labs(x = "", y = "precision and recall (%)", title = "") +
  scale_y_continuous(limits = c(0, 90), breaks = c(0, 20, 40, 60, 80)) +
  scale_fill_manual(values = c("#8586A7","mediumpurple","#547C9B","#B45D52", "orange","#789F5C","#D8B847")) +
  scale_alpha_discrete(range = c(1.0, 0.5))

pdf(file = here("figures", "Figure4B.pdf"), height = 4, width = 7.5)
plot(Protein_Plot)
dev.off()


Precision_v_Read_Count_Plot <- ggplot(data = filtering_metasheet, aes(x=x_val, y=protein_precision,color=sample))+
  geom_line()+
  geom_point()+
  scale_x_continuous(breaks = c(1,2,3,4,5,6,7,8,9,10),labels = c("1","2-4","5-9","10-19","20-39","40-79","80-159","160-319","320-639","640+"))+
  theme(legend.title = element_blank(),
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.x = element_text(angle = 30,vjust=0.4)) +
  labs(x = "Number of reads", y = "precision(%)", title = "")

# Precision_v_Read_Count_Plot
pdf(file = here("figures", "Precision_v_Read_Count.pdf"), height = 4, width = 8)
plot(Precision_v_Read_Count_Plot)
dev.off()

novel <- read_xlsx(here("figure_generation", "figure_data", "novel_stats.xlsx"), sheet = 1)

Plot5 <- ggplot(data = novel[novel$level == "intron chains",], aes(x = factor(dataset, levels = c("L1","L2","L3","L4","YA","GA", "Male"),labels=c("L1","L2","L3","L4","young adult","gravid adult", "male")), y = value, fill = factor(dataset, levels = c("L1","L2","L3","L4","YA","GA", "Male"),labels=c("L1","L2","L3","L4","Young Adult","Gravid Adult", "Male")))) +
  geom_bar(stat = "identity", position = "stack",color="#000000") +
  # geom_text(aes(label=value),position=position_dodge2( width = 0.9 ),vjust= -0.25,size=2.5)+
  theme(legend.title = element_blank(),
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  labs(x = "", y = "novel intron chains", title = "") +
  scale_y_continuous(limits = c(0,7000)) +
  scale_fill_manual(values = c("darkmagenta","darkolivegreen","deepskyblue4","firebrick2","darkturquoise","goldenrod3","darkorange3"))

pdf(file = here("figures", "Figure5A.pdf"), height = 2.5, width = 5)
plot(Plot5)
dev.off()

Plot6 <- ggplot(data = novel[novel$level == "exons",], aes(x = factor(dataset, levels = c("L1","L2","L3","L4","YA","GA", "Male"),labels=c("L1","L2","L3","L4","young adult","gravid adult", "male")), y = value, fill = factor(dataset, levels = c("L1","L2","L3","L4","YA","GA", "Male"),labels=c("L1","L2","L3","L4","Young Adult","Gravid Adult", "Male")))) +
  geom_bar(stat = "identity", position = "stack",color="#000000") +
  # geom_text(aes(label=value),position=position_dodge2( width = 0.9 ),vjust= -0.25,size=2.5)+
  theme(legend.title = element_blank(),
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  labs(x = "", y = "novel exons", title = "") +
  scale_y_continuous(limits = c(0,1100)) +
  scale_fill_manual(values = c("darkmagenta","darkolivegreen","deepskyblue4","firebrick2","darkturquoise","goldenrod3","darkorange3"))

pdf(file = here("figures", "Figure5B.pdf"), height = 2.5, width = 5)
plot(Plot6)
dev.off()

Plot7 <- ggplot(data = novel[novel$level == "introns",], aes(x = factor(dataset, levels = c("L1","L2","L3","L4","YA","GA", "Male"),labels=c("L1","L2","L3","L4","young adult","gravid adult", "male")), y = value, fill = factor(dataset, levels = c("L1","L2","L3","L4","YA","GA", "Male"),labels=c("L1","L2","L3","L4","Young Adult","Gravid Adult", "Male")))) +
  geom_bar(stat = "identity", position = "stack",color="#000000") +
  # geom_text(aes(label=value),position=position_dodge2( width = 0.9 ),vjust= -0.25,size=2.5)+
  theme(legend.title = element_blank(),
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  labs(x = "", y = "novel introns", title = "") +
  scale_y_continuous(limits = c(0,2200)) +
  scale_fill_manual(values = c("darkmagenta","darkolivegreen","deepskyblue4","firebrick2","darkturquoise","goldenrod3","darkorange3"))

pdf(file = here("figures", "Figure5C.pdf"), height = 2.5, width = 5)
plot(Plot7)
dev.off()


Plot8 <- ggplot(data = novel[novel$level == "loci",], aes(x = factor(dataset, levels = c("L1","L2","L3","L4","YA","GA", "Male"),labels=c("L1","L2","L3","L4","young adult","gravid adult", "male")), y = value, fill = factor(dataset, levels = c("L1","L2","L3","L4","YA","GA", "Male"),labels=c("L1","L2","L3","L4","Young Adult","Gravid Adult", "Male")))) +
  geom_bar(stat = "identity", position = "stack",color="#000000") +
  # geom_text(aes(label=value),position=position_dodge2( width = 0.9 ),vjust= -0.25,size=2.5)+
  theme(legend.title = element_blank(),
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  labs(x = "", y = "novel loci", title = "") +
  scale_y_continuous(limits = c(0,120)) +
  scale_fill_manual(values = c("darkmagenta","darkolivegreen","deepskyblue4","firebrick2","darkturquoise","goldenrod3","darkorange3"))

pdf(file = here("figures", "Figure5D.pdf"), height = 2.5, width = 5)
plot(Plot8)
dev.off()


#################################
#################################
## Figure 6A: precision and recall of intron chains for GM12878
IntronChainGM12878Data <- metasheet %>% 
  filter(level == "intron chain", dataset %in% c("GM12878")) %>%
  mutate(tool_stats = paste0(tool, "_", stats))

IntronChain_Plot2 <- ggplot(data = IntronChainGM12878Data, aes(x = tool, y = value, fill = tool)) +
  geom_bar(stat = "identity", position = position_dodge2(),color="#000000",aes( alpha = stats)) +
  geom_text(aes(label=value),position=position_dodge2( width = 0.9 ),vjust= -0.25,size=2.5)+
  facet_wrap(~dataset) +
  theme(legend.title = element_blank(),
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) + 
  labs(x = "", y = "precision and recall (%)", title = "") +
  scale_y_continuous(limits = c(0, 90), breaks = c(0, 20, 40, 60, 80)) +
  scale_fill_manual(values = c("#8586A7","mediumpurple","#547C9B","#B45D52", "orange","#789F5C","#D8B847")) +
  scale_alpha_discrete(range = c(1.0, 0.5))

pdf(file = here("figures", "Figure6A.pdf"), height = 4, width = 6)
plot(IntronChain_Plot2)
dev.off()

#################################
#################################
## Figure 6B: precision and recall of predicted protein products for GM12878
ProteinGM12878Data <- metasheet %>% 
  filter(level == "protein", dataset %in% c("GM12878")) %>%
  mutate(tool_stats = paste0(tool, "_", stats))

Protein_Plot2 <- ggplot(data = ProteinGM12878Data, aes(x = tool, y = value, fill = tool)) +
  geom_bar(stat = "identity", position = position_dodge2(),color="#000000",aes( alpha = stats)) + 
  geom_text(aes(label=value),position=position_dodge2( width = 0.9 ),vjust= -0.25,size=2.5)+
  facet_wrap(~dataset) +
  theme(legend.title = element_blank(),
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) + 
  labs(x = "", y = "precision and recall (%)", title = "") +
  scale_y_continuous(limits = c(0, 90), breaks = c(0, 20, 40, 60, 80)) +
  scale_fill_manual(values = c("#8586A7","mediumpurple","#547C9B","#B45D52", "orange","#789F5C","#D8B847")) +
  scale_alpha_discrete(range = c(1.0, 0.5))

pdf(file = here("figures", "Figure6B.pdf"), height = 4, width = 6)
plot(Protein_Plot2)
dev.off()

GM12878Data <- metasheet %>% 
  filter(level %in% c("intron chain","protein"), dataset %in% c("GM12878")) %>%
  mutate(tool_stats = paste0(tool, "_", stats))

Plot3 <- ggplot(data = GM12878Data, aes(x = tool, y = value, fill = tool)) +
  geom_bar(stat = "identity", position = position_dodge2(),color="#000000",aes( alpha = stats)) + 
  geom_text(aes(label=value),position=position_dodge2( width = 0.9 ),vjust= -0.25,size=2.5)+
  facet_wrap(~level) +
  theme(legend.title = element_blank(),
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) + 
  labs(x = "", y = "precision and recall (%)", title = "") +
  scale_y_continuous(limits = c(0, 90), breaks = c(0, 20, 40, 60, 80)) +
  scale_fill_manual(values = c("#8586A7","mediumpurple","#547C9B","#B45D52", "orange","#789F5C","#D8B847")) +
  scale_alpha_discrete(range = c(1.0, 0.5))

pdf(file = here("figures", "AltFigure6.pdf"), height = 4, width = 8)
plot(Plot3)
dev.off()

NivarData <- metasheet %>% 
  filter(level %in% c("protein"), dataset %in% c("Candida nivariensis")) %>%
  mutate(tool_stats = paste0(tool, "_", stats))

Plot4 <- ggplot(data = NivarData, aes(x = tool, y = value, fill = tool)) +
  geom_bar(stat = "identity", position = position_dodge2(),color="#000000",aes( alpha = stats)) + 
  geom_text(aes(label=value),position=position_dodge2( width = 0.9 ),vjust= -0.25,size=2.5)+
  facet_wrap(~dataset) +
  theme(legend.title = element_blank(),
        text = element_text(size = 10, family = "Helvetica"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) + 
  labs(x = "", y = "precision and recall (%)", title = "") +
  scale_y_continuous(limits = c(0, 100), breaks = c(0, 20, 40, 60, 80)) +
  scale_fill_manual(values = c("#8586A7","mediumpurple","#547C9B","#B45D52", "orange","#D8B847")) +
  scale_alpha_discrete(range = c(1.0, 0.5))

pdf(file = here("figures", "Figure7A.pdf"), height = 4, width = 6)
plot(Plot4)
dev.off()

