import {faAdd, faTrash, faPencil, faEye} from "@fortawesome/free-solid-svg-icons";

export class IconSelector {
    add = faAdd;
    delete = faTrash;
    view = faEye;
    edit = faPencil;
}

export const iconSelector = new IconSelector();