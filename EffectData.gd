extends Resource
class_name EffectData

# The list of cards/tags that should be added to the deck when this card is played
export(Array, String) var addId = []
export(Array, String) var addTag = []

# The list of cards/tags that should be removed from the deck when this card is played
export(Array, String) var removeId = []
export(Array, String) var removeTag = []

# The list of cards/tags that should be added to the hand when this card is played
export(Array, String) var addHandId = []
export(Array, String) var addHandTag = []

# The list of cards/tags that should be removed from the hand when this card is played
export(Array, String) var removeHandId = []
export(Array, String) var removeHandTag = []
