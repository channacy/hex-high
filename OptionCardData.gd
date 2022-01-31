extends Resource
class_name OptionCardData

# Action description
export (String) var flavorText = ""

# Detailed effect description
export (String) var effectText = ""

# The list of cards/tags that should be added to the deck when this card is played
export (Array, String) var addId = []
export (Array, String) var addCategory = []

# The list of cards/tags that should be removed from the deck when this card is played
export (Array, String) var removeId = []
export (Array, String) var removeCategory = []
