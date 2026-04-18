describe('User models', () => {
    describe('UserRole enum', () => {
        it('should have the correct values', () => {
            expect(UserRole.USER).toBe('USER');
            expect(UserRole.ADMIN).toBe('ADMIN');
            expect(UserRole.PARTNER).toBe('PARTNER');
        });
    });

    describe('SubscriptionTier enum', () => {
        it('should have the correct values', () => {
            expect(SubscriptionTier.FREE).toBe('FREE');
            expect(SubscriptionTier.PRO).toBe('PRO');
            expect(SubscriptionTier.PACK).toBe('PACK');
        });
    });

    describe('User interface', () => {
        it('should create a valid User object', () => {
            const user: User = {
                id: '1',
                email: 'test@example.com',
                role: UserRole.USER,
                subscriptionTier: SubscriptionTier.FREE,
                locale: 'en-US',
                timezone: 'UTC',
                createdAt: new Date().toISOString()
            };
            expect(user).toEqual({
                id: '1',
                email: 'test@example.com',
                role: UserRole.USER,
                subscriptionTier: SubscriptionTier.FREE,
                locale: 'en-US',
                timezone: 'UTC',
                createdAt: jasmine.any(String)
            });
        });

        it('should reject an invalid User object due to missing id', () => {
            const user: Partial<User> = {
                email: 'test@example.com',
                role: UserRole.USER,
                subscriptionTier: SubscriptionTier.FREE,
                locale: 'en-US',
                timezone: 'UTC',
                createdAt: new Date().toISOString()
            };
            expect(() => {
                (user as User).id; // This should cause a TypeError
            }).toThrowError(/Cannot read property 'id' of undefined/);
        });

        it('should reject an invalid User object due to invalid role', () => {
            const user: Partial<User> = {
                id: '1',
                email: 'test@example.com',
                role: 'INVALID_ROLE' as UserRole,
                subscriptionTier: SubscriptionTier.FREE,
                locale: 'en-US',
                timezone: 'UTC',
                createdAt: new Date().toISOString()
            };
            expect(() => {
                (user as User).role; // This should cause a TypeError
            }).toThrowError(/Cannot read property 'role' of undefined/);
        });
    });

    describe('TokenResponse interface', () => {
        it('should create a valid TokenResponse object', () => {
            const tokenResponse: TokenResponse = {
                accessToken: 'abc123',
                refreshToken: 'def456',
                expiresIn: 3600,
                tokenType: 'Bearer'
            };
            expect(tokenResponse).toEqual({
                accessToken: 'abc123',
                refreshToken: 'def456',
                expiresIn: 3600,
                tokenType: 'Bearer'
            });
        });

        it('should reject an invalid TokenResponse object due to missing accessToken', () => {
            const tokenResponse: Partial<TokenResponse> = {
                refreshToken: 'def456',
                expiresIn: 3600,
                tokenType: 'Bearer'
            };
            expect(() => {
                (tokenResponse as TokenResponse).accessToken; // This should cause a TypeError
            }).toThrowError(/Cannot read property 'accessToken' of undefined/);
        });

        it('should reject an invalid TokenResponse object due to missing refreshToken', () => {
            const tokenResponse: Partial<TokenResponse> = {
                accessToken: 'abc123',
                expiresIn: 3600,
                tokenType: 'Bearer'
            };
            expect(() => {
                (tokenResponse as TokenResponse).refreshToken; // This should cause a TypeError
            }).toThrowError(/Cannot read property 'refreshToken' of undefined/);
        });

        it('should reject an invalid TokenResponse object due to missing expiresIn', () => {
            const tokenResponse: Partial<TokenResponse> = {
                accessToken: 'abc123',
                refreshToken: 'def456',
                tokenType: 'Bearer'
            };
            expect(() => {
                (tokenResponse as TokenResponse).expiresIn; // This should cause a TypeError
            }).toThrowError(/Cannot read property 'expiresIn' of undefined/);
        });

        it('should reject an invalid TokenResponse object due to missing tokenType', () => {
            const tokenResponse: Partial<TokenResponse> = {
                accessToken: 'abc123',
                refreshToken: 'def456',
                expiresIn: 3600
            };
            expect(() => {
                (tokenResponse as TokenResponse).tokenType; // This should cause a TypeError
            }).toThrowError(/Cannot read property 'tokenType' of undefined/);
        });
    });

    describe('UserPreferences interface', () => {
        it('should create a valid UserPreferences object', () => {
            const userPreferences: UserPreferences = {
                theme: 'light',
                language: 'en-US',
                defaultMode: 'EXAM',
                notificationsEnabled: true,
                freeModeQuestionCount: 10,
                freeModeDurationMin: 5
            };
            expect(userPreferences).toEqual({
                theme: 'light',
                language: 'en-US',
                defaultMode: 'EXAM',
                notificationsEnabled: true,
                freeModeQuestionCount: 10,
                freeModeDurationMin: 5
            });
        });

        it('should reject an invalid UserPreferences object due to missing theme', () => {
            const userPreferences: Partial<UserPreferences> = {
                language: 'en-US',
                defaultMode: 'EXAM',
                notificationsEnabled: true,
                freeModeQuestionCount: 10,
                freeModeDurationMin: 5
            };
            expect(() => {
                (userPreferences as UserPreferences).theme; // This should cause a TypeError
            }).toThrowError(/Cannot read property 'theme' of undefined/);
        });

        it('should reject an invalid UserPreferences object due to missing language', () => {
            const userPreferences: Partial<UserPreferences> = {
                theme: 'light',
                defaultMode: 'EXAM',
                notificationsEnabled: true,
                freeModeQuestionCount: 10,
                freeModeDurationMin: 5
            };
            expect(() => {
                (userPreferences as UserPreferences).language; // This should cause a TypeError
            }).toThrowError(/Cannot read property 'language' of undefined/);
        });

        it('should reject an invalid UserPreferences object due to missing defaultMode', () => {
            const userPreferences: Partial<UserPreferences> = {
                theme: 'light',
                language: 'en-US',
                notificationsEnabled: true,
                freeModeQuestionCount: 10,
                freeModeDurationMin: 5
            };
            expect(() => {
                (userPreferences as UserPreferences).defaultMode; // This should cause a TypeError
            }).toThrowError(/Cannot read property 'defaultMode' of undefined/);
        });

        it('should reject an invalid UserPreferences object due to missing notificationsEnabled', () => {
            const userPreferences: Partial<UserPreferences> = {
                theme: 'light',
                language: 'en-US',
                defaultMode: 'EXAM',
                freeModeQuestionCount: 10,
                freeModeDurationMin: 5
            };
            expect(() => {
                (userPreferences as UserPreferences).notificationsEnabled; // This should cause a TypeError
            }).toThrowError(/Cannot read property 'notificationsEnabled' of undefined/);
        });

        it('should reject an invalid UserPreferences object due to missing freeModeQuestionCount', () => {
            const userPreferences: Partial<UserPreferences> = {
                theme: 'light',
                language: 'en-US',
                defaultMode: 'EXAM',
                notificationsEnabled: true,
                freeModeDurationMin: 5
            };
            expect(() => {
                (userPreferences as UserPreferences).freeModeQuestionCount; // This should cause a TypeError
            }).toThrowError(/Cannot read property 'freeModeQuestionCount' of undefined/);
        });

        it('should reject an invalid UserPreferences object due to missing freeModeDurationMin', () => {
            const userPreferences: Partial<UserPreferences> = {
                theme: 'light',
                language: 'en-US',
                defaultMode: 'EXAM',
                notificationsEnabled: true,
                freeModeQuestionCount: 10
            };
            expect(() => {
                (userPreferences as UserPreferences).freeModeDurationMin; // This should cause a TypeError
            }).toThrowError(/Cannot read property 'freeModeDurationMin' of undefined/);
        });
    });
});