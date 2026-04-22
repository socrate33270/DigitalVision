class HomepageContent
  def services
    [
      {
        title: "Réseaux Sociaux",
        description: "Stratégie de contenu, gestion de communauté et campagnes publicitaires ultra-ciblées.",
        theme: :indigo,
        icon_path: "M13 10V3L4 14h7v7l9-11h-7z"
      },
      {
        title: "Web & Mobile",
        description: "Sites vitrines, applications performantes et parcours de conversion pensés pour vos objectifs business.",
        theme: :purple,
        icon_path: "M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
      },
      {
        title: "Automatisation IA",
        description: "Workflows IA, assistants métier et automatisations pour réduire les tâches répétitives et accélérer vos équipes.",
        theme: :pink,
        featured: true,
        icon_path: "M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"
      }
    ]
  end

  def ai_solutions
    [
      "Automatisation des réponses prospects et qualification CRM",
      "Génération de contenus sociaux alignés avec votre ligne éditoriale",
      "Tableaux de bord IA pour piloter campagnes, leads et performances"
    ]
  end

  def formations
    [
      {
        title: "IA générative pour dirigeants",
        duration: "1 journée",
        description: "Comprendre les usages, les risques et les gains rapides pour cadrer une feuille de route IA."
      },
      {
        title: "ChatGPT & automatisation métier",
        duration: "2 jours",
        description: "Créer des prompts robustes, automatiser des tâches et documenter des workflows reproductibles."
      },
      {
        title: "Création visuelle IA",
        duration: "1 journée",
        description: "Produire des visuels cohérents pour campagnes sociales, ads et supports de marque."
      }
    ]
  end
end
