import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'duration'
})
export class DurationPipe implements PipeTransform {
  transform(value: number): string {
    
    const hours = Math.floor(value / 60);
    const minutes = value % 60;

    if (hours === 0) {
      return `${minutes} minute(s)`
    } else if (minutes === 0) {
      return `${hours} hour(s)`
    } else {
      return `${hours} hour(s) ${minutes} minute(s)`
    }
  }
}