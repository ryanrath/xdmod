import {expect, Locator, Page} from "@playwright/test";
import selectors from "./xdmod.selectors";

export class BasePage {
    readonly page: Page;
    readonly maskSelector: string;
    readonly mask: Locator;
    readonly baseUrl: string;
    readonly selectors = selectors;

    constructor(page: Page, baseUrl: string) {
        this.page = page;
        this.maskSelector = '.ext-el-mask-msg';
        this.mask = page.locator(this.maskSelector);
        this.baseUrl = baseUrl;
    }

    public async verifyLocation(url: string, expectedTitle: string) {
        const newUrl = new URL(url, this.baseUrl);
        try{
         await this.page.goto(newUrl.toString());
        }catch(error){
          throw new Error(error);
        }
        const title = await this.page.title();
        expect(title).toEqual(expectedTitle);
    }

    /**
     * This function checks that all "mask" elements ( one or more ) are hidden since the number of masks is not
     * what's important ( or tested here ), just that every mask element is hidden so that a user can interact with the
     * site.
     */
    public async expectMaskToBeHidden() {
        const maskLocator = this.page.locator(this.selectors.mask);
        for (const mask of await maskLocator.all()) {
            await expect(mask).toBeHidden();
        }
    }
}
