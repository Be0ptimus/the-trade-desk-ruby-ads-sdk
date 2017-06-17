module TheTradeDeskAds
  class AdRtbAdGroupAttributes < Base

    FIELDS = %w[
      BudgetSettings
      BaseBidCPM
      MaxBidCPM
      AudienceTargeting
      ROIGoal
      FrequencySettings
      CreativeIds
      AdFormatAdjustments
      GeoSegmentAdjustments
      UserTimeTargeting
      SiteTargeting
      FoldTargeting
      SupplyVendorAdjustments
      BrowserAdjustments
      OSAdjustments
      OSFamilyAdjustments
      DeviceTypeAdjustments
      RenderingContextAdjustments
      AutoOptimizationSettings
      ContractTargeting
      VideoTargeting
      SiteQualitySettings
      NielsenSettings
      ComscoreSettings
      LanguageTargeting
      QualityAllianceViewabilityTargeting
    ].freeze

    BROWSER_ADJUSTMENT_OPTIONS = %w[ 
      "Other",
      "InternetExplorer7",
      "InternetExplorer8",
      "InternetExplorer9",
      "Firefox",
      "Chrome",
      "Safari",
      "Opera",
      "InternetExplorer10",
      "InternetExplorer11",
      "InApp",
      "Edge"
    ]

    OS_ADJUSTMENT_OPTIONS = %w[
      "Other",
      "WindowsXP",
      "WindowsVista",
      "Windows7",
      "Windows8",
      "Android23",
      "Android40",
      "Android41",
      "Android42",
      "Android43",
      "Android44",
      "Android50",
      "iOS51",
      "iOS60",
      "iOS61",
      "iOS70",
      "iOS71",
      "iOS80",
      "iOS81",
      "WindowsPhone80",
      "WindowsPhone81",
      "WindowsPhone",
      "Windows10"
    ]

    OS_FAMILY_ADJUSTMENT_OPTIONS = %w[
      "Other",
      "Windows",
      "OSX",
      "Linux",
      "iOS",
      "Android",
      "WindowsPhone"
    ]

    DEVICE_TYPE_ADJUSTMENTS_OPTIONS = %w[
      "Other",
      "PC",
      "Tablet",
      "Mobile",
      "Roku"
    ]
    RENDERING_CONTEXT_ADJUSTMENTS_OPTIONS = %w[
      "Other",
      "InApp",
      "MobileOptimizedWeb"
    ]

    class << self
    end

  end
end
