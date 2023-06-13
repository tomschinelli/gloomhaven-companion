import characterMats from "$lib/data/character-mats.json"
import monsterStatCards from "$lib/data/monster-stat-cards.json"
import type {Expansion} from "$lib/expansion";
import type {CharacterMat} from "$lib/Character";
import {Character} from "$lib/Character";


/**
 * CharacterApi requests character related information.
 * An Enemy is also character
 *
 * todo load via server
 */
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
            const image = "images/" + mat.image
            isBack ? found.backImage = image : found.frontImage = image;
        }
        return characters;
    }

    getEnemies(expansions: Expansion[]) {
        const mats = monsterStatCards as CharacterMat[]
        const characters: Character[] = []
        const expansionMats = mats.filter(x =>
            (expansions as string []).includes(x.expansion.toLowerCase()))
        for (let mat of expansionMats) {
            let found = characters.find(x => x.id == mat.xws)
            if (found) continue;
            const image = "images/" + mat.image
            found = new Character({
                id: mat.xws,
                type: 'enemy',
                name: mat.name,
                backImage: image,
                frontImage: image,
            })
            characters.push(found)
        }
        return characters;
    }
}