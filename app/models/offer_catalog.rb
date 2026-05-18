class OfferCatalog
  def navigation_items
    [
      { label: "Community management", anchor: "community-management" },
      { label: "Sites web", anchor: "sites-web" },
      { label: "Combos", anchor: "offres-combinees" },
      { label: "Comparatif", anchor: "comparatif-cm" }
    ]
  end

  def community_management_plans
    [
      OfferPlan.new(
        slug: "essentiel",
        badge: "Starter",
        name: "Essentiel",
        description: "1 reseau au choix, rythme reduit. Ideal pour tester.",
        price: "300",
        billing_detail: "/ mois",
        theme: :slate,
        included_features: [
          "1 reseau au choix (Facebook, Instagram ou LinkedIn)",
          "2 posts par semaine",
          "Redaction personnalisee",
          "Adaptation visuelle basique",
          "Bilan mensuel simplifie"
        ],
        cta_label: "Choisir Essentiel",
        engagement: "Sans engagement"
      ),
      OfferPlan.new(
        slug: "duo-reseaux",
        badge: "Essentiel",
        name: "Duo Reseaux",
        description: "2 reseaux au choix. Le pack de depart complet.",
        price: "450",
        billing_detail: "/ mois",
        theme: :indigo,
        included_features: [
          "2 reseaux au choix (Facebook, Instagram ou LinkedIn)",
          "2 posts par semaine par reseau",
          "Strategie initiale + document de positionnement",
          "Redaction personnalisee",
          "Adaptation contenu par reseau, sans copie-colle",
          "Bilan mensuel avec chiffres d'engagement"
        ],
        cta_label: "Choisir Duo Reseaux",
        engagement: "Sans engagement",
        featured: true,
        featured_label: "Recommande"
      ),
      OfferPlan.new(
        slug: "full-presence",
        badge: "Pro",
        name: "Full Presence",
        description: "Gestion complete sur 3 reseaux et engagement communaute.",
        price: "650",
        billing_detail: "/ mois",
        theme: :orange,
        included_features: [
          "3 reseaux au choix (Instagram, Facebook ou LinkedIn)",
          "3 posts par semaine",
          "Stories ou video 2x / semaine (Instagram, Facebook ou LinkedIn)",
          "Reponse aux commentaires et avis Google",
          "Strategie initiale complete",
          "Bilan mensuel detaille + recommandations",
          "1 reel ou video courte par mois",
          "Realisation des visuels par notre agence",
          "Veille concurrentielle locale"
        ],
        cta_label: "Choisir Full Presence",
        engagement: "Sans engagement"
      )
    ]
  end

  def website_plans
    [
      OfferPlan.new(
        slug: "presence-web",
        badge: "Site vitrine",
        name: "Presence Web",
        description: "Pour artisans, commerces et professions liberales.",
        price: "800",
        price_context: "Tarif de creation",
        theme: :emerald,
        pricing: :one_time,
        included_features: [
          "Jusqu'a 5 pages",
          "Design sur mesure responsive",
          "Formulaire de contact",
          "Optimisation SEO de base",
          "Integration Google Maps",
          "Formation 1h a la mise a jour"
        ],
        excluded_features: [
          "Pas de back-office",
          "Pas de systeme de reservation"
        ],
        footer_note: "Maintenance optionnelle : 50EUR/mois pour les mises a jour, la securite et les sauvegardes.",
        cta_label: "Demander ce site",
        engagement: "Sans engagement"
      ),
      OfferPlan.new(
        slug: "hotels-restaurants",
        badge: "Site + back-office",
        name: "Hotels & Restaurants",
        description: "Interface d'administration pour gerer les offres, menus et disponibilites.",
        price: "1 800",
        price_context: "Tarif de creation",
        theme: :amber,
        pricing: :one_time,
        included_features: [
          "Site vitrine complet jusqu'a 8 pages",
          "Back-office sur mesure",
          "Gestion menus, offres et tarifs",
          "Galerie photos administrable",
          "Integration reservation type Booking ou Zenchef",
          "SEO local avance",
          "Formation 2h a l'administration",
          "3 mois de support inclus"
        ],
        footer_note: "Maintenance optionnelle : 80EUR/mois pour le support, les mises a jour et les sauvegardes.",
        cta_label: "Parler du back-office",
        engagement: "Sans engagement"
      ),
      OfferPlan.new(
        slug: "projet-complexe",
        badge: "Sur mesure",
        name: "Projet Complexe",
        description: "E-commerce, plateforme ou fonctionnalites specifiques.",
        price: "Sur devis",
        price_context: "Devis gratuit sous 48h avec un appel de cadrage de 30 min.",
        theme: :charcoal,
        pricing: :quote,
        included_features: [
          "Boutique e-commerce",
          "Plateforme de mise en relation",
          "Site multilingue",
          "Integration CRM et outils metier",
          "Application web progressive"
        ],
        cta_label: "Demander un devis",
        engagement: "Sans engagement"
      )
    ]
  end

  def bundles
    [
      OfferBundle.new(
        title: "Artisan Local",
        description: "Site vitrine + Pack Essentiel CM (1 reseau)",
        discounted_price: "990EUR",
        original_price: "1 100EUR",
        details: "Site vitrine (800EUR) + 1 mois CM Essentiel (300EUR) : 110EUR offerts."
      ),
      OfferBundle.new(
        title: "Hotel & Restaurant",
        description: "Site back-office + Pack Duo Reseaux 3 mois",
        discounted_price: "3 050EUR",
        original_price: "3 150EUR",
        details: "Site back-office (1 800EUR) + 3 mois CM Duo (450EUR x3) : 100EUR offerts."
      ),
      OfferBundle.new(
        title: "Commerce & Independant",
        description: "Site vitrine + Pack Duo Reseaux 3 mois",
        discounted_price: "2 100EUR",
        original_price: "2 150EUR",
        details: "Site vitrine (800EUR) + 3 mois CM Duo (450EUR x3) : 50EUR offerts."
      )
    ]
  end

  def comparison_rows
    [
      OfferComparisonRow.new(
        label: "Nombre de reseaux",
        values: [
          OfferComparisonValue.text("1 au choix"),
          OfferComparisonValue.text("2 au choix"),
          OfferComparisonValue.text("3 au choix")
        ]
      ),
      OfferComparisonRow.new(
        label: "Posts par semaine",
        values: [
          OfferComparisonValue.text("2"),
          OfferComparisonValue.text("2 x 2 reseaux"),
          OfferComparisonValue.text("3 x reseaux")
        ]
      ),
      OfferComparisonRow.new(
        label: "Strategie initiale",
        values: [
          OfferComparisonValue.no,
          OfferComparisonValue.yes,
          OfferComparisonValue.yes
        ]
      ),
      OfferComparisonRow.new(
        label: "Adaptation par reseau",
        values: [
          OfferComparisonValue.no,
          OfferComparisonValue.yes,
          OfferComparisonValue.yes
        ]
      ),
      OfferComparisonRow.new(
        label: "Stories ou video",
        values: [
          OfferComparisonValue.no,
          OfferComparisonValue.no,
          OfferComparisonValue.yes("✓ 2x/sem")
        ]
      ),
      OfferComparisonRow.new(
        label: "Reponse commentaires et avis",
        values: [
          OfferComparisonValue.no,
          OfferComparisonValue.no,
          OfferComparisonValue.yes
        ]
      ),
      OfferComparisonRow.new(
        label: "1 reel ou video courte / mois",
        values: [
          OfferComparisonValue.no,
          OfferComparisonValue.no,
          OfferComparisonValue.yes
        ]
      ),
      OfferComparisonRow.new(
        label: "Bilan mensuel",
        values: [
          OfferComparisonValue.text("Simplifie"),
          OfferComparisonValue.text("Complet"),
          OfferComparisonValue.text("Complet + recommandations")
        ]
      ),
      OfferComparisonRow.new(
        label: "Realisation des visuels",
        values: [
          OfferComparisonValue.yes,
          OfferComparisonValue.yes,
          OfferComparisonValue.yes
        ]
      ),
      OfferComparisonRow.new(
        label: "Engagement",
        values: [
          OfferComparisonValue.text("Sans engagement"),
          OfferComparisonValue.text("Sans engagement"),
          OfferComparisonValue.text("Sans engagement")
        ]
      )
    ]
  end

  def community_management_note
    "Notre agence s'occupe de la realisation des visuels pour vos contenus social media, avec une direction adaptee a votre marque et a chaque reseau."
  end

  def bundles_note
    "Un site bien concu sans reseaux reste discret. Des reseaux actifs sans site professionnel manquent de credibilite. Les deux ensemble creent un ecosysteme coherent ou chaque canal renforce l'autre."
  end
end
