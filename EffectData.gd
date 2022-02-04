extends Resource
class_name EffectData

# The list of cards/tags that should be added to the deck when this card is played
export(Array, String) var addId = []
export(Array, String) var addCategory = []

# The list of cards/tags that should be removed from the deck when this card is played
export(Array, String) var removeId = []
export(Array, String) var removeCategory = []
