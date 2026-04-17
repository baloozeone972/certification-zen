// certif-parent/certif-web/src/app/core/models/api.models.ts

/** Generic API response envelope. */
export interface ApiResponse<T> {
    data: T;
    message: string;
    timestamp: string;
}

/** Standardised error response. */
export interface ErrorResponse {
    status: number;
    message: string;
    errors: FieldError[];
    timestamp: string;
}

export interface FieldError {
    field: string;
    message: string;
}

/** Pagination wrapper. */
export interface PageResponse<T> {
    content: T[];
    totalElements: number;
    totalPages: number;
    page: number;
    size: number;
}
