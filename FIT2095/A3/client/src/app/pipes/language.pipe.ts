import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'language'
})
export class LanguagePipe implements PipeTransform {

  transform(value: string): string  {
    if (value === "en") {
      return "english (en)";
    }
    if (value === "fr") {
      return "french (fr)";
    }
    if (value === "de") {
      return "german (de)";
    }
    return "unknown";
  }
}
