
import 'AppIcons.dart';

enum ImageType { asset, file, network }

const weatherCodeJson = {
  "0":{
    "day":{
      "description":"Sunny",
      "image":AppIcons.sunny0
    },
    "night":{
      "description":"Clear",
      "image":AppIcons.clear0
    }
  },
  "1":{
    "day":{
      "description":"Mainly Sunny",
      "image":AppIcons.mainlySunny1
    },
    "night":{
      "description":"Mainly Clear",
      "image":AppIcons.mainlyClear1
    }
  },
  "2":{
    "day":{
      "description":"Partly Cloudy",
      "image":AppIcons.partlyCloudy2
    },
    "night":{
      "description":"Partly Cloudy",
      "image":AppIcons.partlyCloudyMoon2
    }
  },
  "3":{
    "day":{
      "description":"Cloudy",
      "image":AppIcons.cloudySun3
    },
    "night":{
      "description":"Cloudy",
      "image":AppIcons.cloudyMoon3
    }
  },
  "45":{
    "day":{
      "description":"Foggy",
      "image":AppIcons.fogSun45_48
    },
    "night":{
      "description":"Foggy",
      "image":AppIcons.fogMoon45_48
    }
  },
  "48":{
    "day":{
      "description":"Rime Fog",
      "image":AppIcons.fogSun45_48
    },
    "night":{
      "description":"Rime Fog",
      "image":AppIcons.fogMoon45_48
    }
  },
  "51":{
    "day":{
      "description":"Light Drizzle",
      "image":AppIcons.lightDrizzleSun51
    },
    "night":{
      "description":"Light Drizzle",
      "image":AppIcons.drizzle
    }
  },
  "53":{
    "day":{
      "description":"Drizzle",
      "image":AppIcons.lightDrizzleSun51
    },
    "night":{
      "description":"Drizzle",
      "image":AppIcons.drizzle
    }
  },
  "55":{
    "day":{
      "description":"Heavy Drizzle",
      "image":AppIcons.lightDrizzleSun51
    },
    "night":{
      "description":"Heavy Drizzle",
      "image":AppIcons.drizzle
    }
  },
  "56":{
    "day":{
      "description":"Light Freezing Drizzle",
      "image":AppIcons.lightDrizzleSun51
    },
    "night":{
      "description":"Light Freezing Drizzle",
      "image":AppIcons.drizzle
    }
  },
  "57":{
    "day":{
      "description":"Freezing Drizzle",
      "image":AppIcons.lightDrizzleSun51
    },
    "night":{
      "description":"Freezing Drizzle",
      "image":AppIcons.drizzle
    }
  },
  "61":{
    "day":{
      "description":"Light Rain",
      "image":AppIcons.lightRainSun61
    },
    "night":{
      "description":"Light Rain",
      "image":AppIcons.rainMoon
    }
  },
  "63":{
    "day":{
      "description":"Rain",
      "image":AppIcons.heavyRainDay
    },
    "night":{
      "description":"Rain",
      "image":AppIcons.heavyRainNight
    }
  },
  "65":{
    "day":{
      "description":"Heavy Rain",
      "image":AppIcons.heavyRainDay
    },
    "night":{
      "description":"Heavy Rain",
      "image":AppIcons.heavyRainNight
    }
  },
  "66":{
    "day":{
      "description":"Light Freezing Rain",
      "image":AppIcons.freezingRainDay
    },
    "night":{
      "description":"Light Freezing Rain",
      "image":AppIcons.freezingRainNight
    }
  },
  "67":{
    "day":{
      "description":"Freezing Rain",
      "image":AppIcons.freezingRainDay
    },
    "night":{
      "description":"Freezing Rain",
      "image":AppIcons.freezingRainNight
    }
  },
  "71":{
    "day":{
      "description":"Light Snow",
      "image":AppIcons.snowDay
    },
    "night":{
      "description":"Light Snow",
      "image":AppIcons.snowNight
    }
  },
  "73":{
    "day":{
      "description":"Snow",
      "image":AppIcons.snowDay
    },
    "night":{
      "description":"Snow",
      "image":AppIcons.snowNight
    }
  },
  "75":{
    "day":{
      "description":"Heavy Snow",
      "image":AppIcons.snowDay
    },
    "night":{
      "description":"Heavy Snow",
      "image":AppIcons.snowNight
    }
  },
  "77":{
    "day":{
      "description":"Snow Grains",
      "image":AppIcons.snowGrainsDay
    },
    "night":{
      "description":"Snow Grains",
      "image":AppIcons.snowGrainsNight
    }
  },
  "80":{
    "day":{
      "description":"Light Showers",
      "image":AppIcons.heavyRainDay
    },
    "night":{
      "description":"Light Showers",
      "image":AppIcons.heavyRainNight
    }
  },
  "81":{
    "day":{
      "description":"Showers",
      "image":AppIcons.heavyRainDay
    },
    "night":{
      "description":"Showers",
      "image":AppIcons.heavyRainNight
    }
  },
  "82":{
    "day":{
      "description":"Heavy Showers",
      "image":AppIcons.heavyRainDay
    },
    "night":{
      "description":"Heavy Showers",
      "image":AppIcons.heavyRainNight
    }
  },
  "85":{
    "day":{
      "description":"Light Snow Showers",
      "image":AppIcons.snowGrainsDay
    },
    "night":{
      "description":"Light Snow Showers",
      "image":AppIcons.snowGrainsNight
    }
  },
  "86":{
    "day":{
      "description":"Snow Showers",
      "image":AppIcons.snowGrainsDay
    },
    "night":{
      "description":"Snow Showers",
      "image":AppIcons.snowGrainsNight
    }
  },
  "95":{
    "day":{
      "description":"Thunderstorm",
      "image":AppIcons.thunderstormDay
    },
    "night":{
      "description":"Thunderstorm",
      "image":AppIcons.thunderstormNight
    }
  },
  "96":{
    "day":{
      "description":"Light Thunderstorms With Hail",
      "image":AppIcons.thunderstormDay
    },
    "night":{
      "description":"Light Thunderstorms With Hail",
      "image":AppIcons.thunderstormNight
    }
  },
  "99":{
    "day":{
      "description":"Thunderstorm With Hail",
      "image":AppIcons.thunderstormDay
    },
    "night":{
      "description":"Thunderstorm With Hail",
      "image":AppIcons.thunderstormNight
    }
  }
};
