module OffersHelper
  def offer_theme_classes(theme)
    {
      slate: {
        panel: "border-white/10 bg-white/[0.03]",
        header: "bg-white/[0.04]",
        badge: "bg-white/10 text-slate-200",
        accent: "text-slate-200",
        muted: "text-gray-400",
        button: "bg-white text-black hover:bg-gray-200",
        note: "border-slate-400/20 bg-white/5 text-slate-100"
      },
      indigo: {
        panel: "border-indigo-400/25 bg-indigo-500/[0.05]",
        header: "bg-gradient-to-br from-indigo-500/20 to-indigo-500/5",
        badge: "bg-indigo-500 text-white",
        accent: "text-indigo-300",
        muted: "text-indigo-100/75",
        button: "bg-indigo-500 text-white hover:bg-indigo-400",
        note: "border-indigo-400/20 bg-indigo-500/10 text-indigo-100"
      },
      orange: {
        panel: "border-orange-400/25 bg-orange-500/[0.05]",
        header: "bg-gradient-to-br from-orange-500/18 to-orange-500/5",
        badge: "bg-orange-500 text-white",
        accent: "text-orange-300",
        muted: "text-orange-100/75",
        button: "bg-orange-500 text-white hover:bg-orange-400",
        note: "border-orange-400/20 bg-orange-500/10 text-orange-100"
      },
      purple: {
        panel: "border-purple-400/25 bg-purple-500/[0.05]",
        header: "bg-gradient-to-br from-purple-500/20 to-purple-500/5",
        badge: "bg-purple-500 text-white",
        accent: "text-purple-300",
        muted: "text-purple-100/75",
        button: "bg-purple-500 text-white hover:bg-purple-400",
        note: "border-purple-400/20 bg-purple-500/10 text-purple-100"
      },
      emerald: {
        panel: "border-emerald-400/25 bg-emerald-500/[0.05]",
        header: "bg-gradient-to-br from-emerald-500/18 to-emerald-500/5",
        badge: "bg-emerald-500 text-white",
        accent: "text-emerald-300",
        muted: "text-emerald-100/75",
        button: "bg-emerald-500 text-white hover:bg-emerald-400",
        note: "border-emerald-400/20 bg-emerald-500/10 text-emerald-100"
      },
      amber: {
        panel: "border-amber-300/25 bg-amber-500/[0.05]",
        header: "bg-gradient-to-br from-amber-400/20 to-amber-500/5",
        badge: "bg-amber-400 text-black",
        accent: "text-amber-200",
        muted: "text-amber-100/75",
        button: "bg-amber-400 text-black hover:bg-amber-300",
        note: "border-amber-300/20 bg-amber-400/10 text-amber-50"
      },
      charcoal: {
        panel: "border-white/10 bg-[#05070d]",
        header: "bg-gradient-to-br from-[#111827] via-[#0f172a] to-black",
        badge: "bg-orange-500 text-white",
        accent: "text-orange-300",
        muted: "text-gray-400",
        button: "bg-white text-black hover:bg-orange-100",
        note: "border-orange-400/20 bg-orange-500/10 text-orange-100"
      }
    }.fetch(theme)
  end

  def comparison_value_classes(value)
    return "font-semibold text-emerald-300" if value.yes?
    return "text-gray-500" if value.no?

    "text-gray-200"
  end
end
