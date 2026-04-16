// certif-parent/certif-web/src/app/shared/pipes/duration.pipe.ts
import { Pipe, PipeTransform } from "@angular/core";

/** Converts seconds to HH:MM:SS or MM:SS display string. */
@Pipe({ name: "duration", standalone: true })
export class DurationPipe implements PipeTransform {
  transform(seconds: number | null | undefined): string {
    if (!seconds && seconds !== 0) return "--";
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    const s = seconds % 60;
    if (h > 0) {
      return `${h}h${m.toString().padStart(2,"0")}m${s.toString().padStart(2,"0")}s`;
    }
    return `${m.toString().padStart(2,"0")}:${s.toString().padStart(2,"0")}`;
  }
}
