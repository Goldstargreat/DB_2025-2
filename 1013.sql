SELECT id, name, publish_name, author FROM BOOK b, PUBLISH p 
                                          where b.publish_id = p.publish_id;