//
//  Product.swift
//  LCBOApp
//
//  Created by John Schisler on 2016-11-20.
//  Copyright © 2016 John Schisler. All rights reserved.
//

import Foundation

struct Product {

    // Product name
    let name : String;
    
    // Current retail price in cents
    // price_in_cents
    let price : Double;

    // Primary product category
    // primary_category
    let primaryCategory : String;

    // Alcohol content (Divide by 100 for decimal value)
    // alcohol_content
    //let alcoholContent : Double;

    // A URL to an image of the product (Not available for all products)
    // image_url
    let imageUrl : String
    
    // A URL to a smaller image of the product (Not available for all products)
    // image_thumb_url
    let imageThumbUrl : String

    /*
     bonus_reward_miles;                    // Number of bonus air miles
     bonus_reward_miles_ends_on;            // When bonus air miles are no longer valid
     clearance_sale_savings_in_cents;       // Savings in cents if on clearance [Deprecated]
     description;                           // Product description (not available for all products)
     has_bonus_reward_miles                 // True if the product has bonus air miles
     has_clearance_sale;                    // True if the product is currently on clearance [Deprecated]
     has_limited_time_offer;                // True if the product is on sale
     has_value_added_promotion;             // True if the product has a value added promotion
     id;                                    // The LCBO product ID / number
     inventory_count;                       // Total units across all stores
     inventory_price_in_cents;              // Total retail price of all units across all stores
     inventory_volume_in_milliliters;       // Total volume of all units across all stores
     is_dead;                               // When products are removed from the LCBO catalog they are marked as “dead”
     is_discontinued;                       // True if the product has been marked as discontinued by the LCBO
     is_kosher;                             // True if the product is designated as Kosher.
     is_seasonal;                           // True if the product is designated as seasonal
     is_vqa;                                // True if the product is designated as VQA
     is_ocb;                                // True if the product is produced by a member of the Ontario Craft Brewers
     limited_time_offer_ends_on;            // When the sale price is no longer valid
     limited_time_offer_savings_in_cents;   // Savings in cents if on sale
     origin;                                // Country of origin / manufacture
     package;                               // Full package description
     package_unit_type;                     // Package unit type (bottle, can, etc.)
     package_unit_volume_in_milliliters;    // The volume of one unit in the package
     price_per_liter_in_cents;              // The beverage price per liter
     price_per_liter_of_alcohol_in_cents;   // The alcohol price per liter
     producer_name;                         // Name of the company that produces the product
     product_no;                            // The LCBO product ID / number [Deprecated]
     regular_price_in_cents;                // Regular retail price in cents
     released_on;                           // Official release date (usually unspecified)
     secondary_category;                    // Secondary LCBO product category (Not available for all products)
     serving_suggestion;                    // LCBO serving suggestion (Not available for all products)
     style;                                 // The LCBO’s determined style designation (Not available for most products)
     tertiary_category;                     // Tertiary LCBO product category (Not available for all products)
     stock_type;                            // Either “LCBO” or “VINTAGES”
     sugar_content;                         // The product’s sweetness descriptor, is usually a designation such as extra-dry (XD), medium sweet (MS), etc. (Not available for all products)
     sugar_in_grams_per_liter;              // The amount of sugar that is contained in the product in grams per liter. (Not available for all products)
     tags;                                  // A string of tags that reflect the product
     tasting_note;                          // Professional tasting note (Not available for all products)
     total_package_units;                   // Number of units in a package
     updated_at;                            // Time that the product information was updated
     value_added_promotion_description;     // Contents of the value added promotion offer if available
     varietal;                              // Grape varietal (or blend) designated by the LCBO (Not available for all products)
     volume_in_milliliters;                 // Total volume of all units in package
     
     */
}
