export interface CharacterMat{
    name: string
    points: number,
    expansion: "GLo",
    image: "character-mats/gloomhaven/gh-tinkerer.png",
    xws: "tinkerer"
}
export class Character{
    id: string;
    name: string;
    frontImage?: string
    backImage?: string


    constructor(args: Partial<Character>) {
        this.name = args?.name ?? "";
        this.id = args?.id ?? "";
        this.frontImage = args?.frontImage ;
        this.backImage = args?.backImage ;

    }
}