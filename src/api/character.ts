import characterMats from "../data/character-mats.json"
import type {Expansion} from "../models/expansion";
import type {CharacterMat} from "../models/character";
import {Character} from "../models/character";


export class CharacterApi {

    getCharacters(expansions: Expansion[]) {
        const mats = characterMats as CharacterMat[]

        const expansionMats = mats.filter(x =>
            (expansions as string []).includes(x.expansion.toLowerCase()))

        const characters: Character[] = []
        for (let mat of expansionMats) {
            let found = characters.find(x => x.id == mat.xws)
            if (!found) {
                found = new Character({
                    id: mat.xws,
                    name: mat.name,
                })
                characters.push(found)
            }
            const isBack = mat.image.endsWith("-back.png");
            const image = "images/"+mat.image
            isBack ? found.backImage = image : found.frontImage = image;
        }
        return characters;
    }
}