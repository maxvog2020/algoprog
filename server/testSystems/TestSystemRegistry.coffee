import Informatics from './Informatics'
import Ejudge from './Ejudge'

export REGISTRY = 
    "informatics": new Informatics()
    "ejudge": new Ejudge('https://ejudge.algoprog.ru', 2000)

export default getTestSystem = (id) ->
    REGISTRY[id]
